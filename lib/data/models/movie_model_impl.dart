import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_request_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/data/vos/config_data_vo.dart';
import 'package:movie_booking_app/data/vos/credit_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_date_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/data/vos/seat_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/ticket_vo.dart';
import 'package:movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_response.dart';
import 'package:movie_booking_app/persistence/daos/config_data_dao.dart';
import 'package:movie_booking_app/persistence/daos/payment_type_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistence/daos/banner_dao.dart';
import '../../persistence/daos/cinema_dao.dart';
import '../../persistence/daos/city_dao.dart';
import '../../persistence/daos/credit_dao.dart';
import '../../persistence/daos/genre_dao.dart';
import '../../persistence/daos/movie_dao.dart';
import '../../persistence/daos/movie_date_timeslots_dao.dart';
import '../../persistence/daos/snack_category_dao.dart';
import '../../persistence/daos/snack_dao.dart';
import '../../persistence/daos/user_dao.dart';
import '../vos/user_vo.dart';
import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  UserDao mUserDao = UserDao();
  BannerDao mBannerDao = BannerDao();
  CityDao mCityDao = CityDao();
  CreditDao mCreditDao = CreditDao();
  CinemaDao mCinemaDao = CinemaDao();
  SnackDao mSnackDao = SnackDao();
  SnackCategoryDao mSnackCategoryDao = SnackCategoryDao();
  PaymentTypeDao mPaymentTypeDao = PaymentTypeDao();
  MovieDateTimeSlotDao mMovieDateTimeSlotsDao = MovieDateTimeSlotDao();
  ConfigDataDao mConfigDataDao = ConfigDataDao();

  UserVO? mUserVO;

  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isCommingSoon = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      // return Future.value(movies);
    });
  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mDataAgent.getGenres()?.then((genres) async {
      mGenreDao.saveAllGenres(genres);
      return Future.value(genres);
    });
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetail(movieId)?.then((movie) async {
      MovieVO? movieFromList = mMovieDao.getMovieById(movie.id ?? 0);
      print("save movie detail ${movieFromList.toString()}");
      movie.isNowPlaying = movieFromList?.isNowPlaying;
      movie.isCommingSoon = movieFromList?.isCommingSoon;
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  @override
  void getCommingSoonMovies(int page) {
    mDataAgent.getCommingSoonMovies(page)?.then((movies) async {
      List<MovieVO> commingSoonMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isCommingSoon = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(commingSoonMovies);
      // return Future.value(movies);
    });
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  void getBanners() {
    mDataAgent.getBanners()?.then((bannersList) async {
      mBannerDao.saveAllBanners(bannersList);
    });
  }

  @override
  void getCities() {
    mDataAgent.getCities()?.then((citiesList) async {
      mCityDao.saveAllCities(citiesList);
    });
  }

  @override
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlots() {
    mDataAgent.getConfig()?.then((responseList) async {
      mConfigDataDao.saveAllConfigs(responseList);
    });
    return mDataAgent
        .getConfig()
        ?.asStream()
        .map((response) => response
            .where((element) => element.key == "cinema_timeslot_status")
            .toList())
        .first;
  }

  @override
  Future<BasicResponse>? getOTP(String phNumber) {
    return mDataAgent.getOTP(phNumber);
  }

  @override
  Future<BasicResponse>? signInWithGoogle(String accessToken, String name) {
    return mDataAgent.postSignInWithGoogle(accessToken, name);
  }

  @override
  Future<SignInResponse>? signInWithPhone(String phNumber, String otp) {
    return mDataAgent
        .postSignInWithPhone(phNumber, otp)
        ?.then((response) async {
      UserVO? userVO = response.data;
      userVO?.token = response.token;
      if (userVO != null) {
        mUserDao.saveUser(userVO!);
      }
      return Future.value(response);
    });
  }

  @override
  void getSnacksList(String authorizationToken, int? categoryId) {
    print("Cate ${categoryId}");
    mDataAgent
        .getSnacksList(authorizationToken, categoryId)
        ?.then((snacksList) async {
      mSnackDao.saveAllSnacks(snacksList);
    });
  }

  @override
  Future<BasicResponse>? setCity(String authorizationToken, String cityId) {
    UserVO? mUserVO = getLoginUser();
    if (mUserVO != null) {
      print(
          "Savingg city cityID ==> ${cityId} ===> ${mCityDao.getAllCities().toString()}");
      mUserVO?.selectedCity = mCityDao.getCityById(int.parse(cityId));
      print("City Query ${mCityDao.getCityById(cityId)}");
      print("update user ${mUserVO.toString()}");
      mUserDao.saveUser(mUserVO!);
    }
    return mDataAgent.setCity(authorizationToken, cityId);
  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(
      String authorizationToken, String date) {
    return mDataAgent
        .getCinemaAndShowTimeByDate(authorizationToken, date)
        ?.then((timeslotsList) async {
      mMovieDateTimeSlotsDao.saveSingleMovieDateTimeSlotDaoByDate(
          MovieDateTimeSlotsVO(date, timeslotsList));
      return Future.value(timeslotsList);
    });
  }

  @override
  Future<List<CinemaVO>>? getCinemasList(String? latestTime) {
    return mDataAgent.getCinemasList(latestTime)?.then((cinemaList) async {
      mCinemaDao.saveAllCinemas(cinemaList);
      return Future.value(cinemaList);
    });
  }

  @override
  void getPaymentTypes(String authorizationToken) {
    mDataAgent
        .getPaymentTypes(authorizationToken)
        ?.then((paymentTypesList) async {
      mPaymentTypeDao.saveAllPaymentTypes(paymentTypesList);
    });
  }

  @override
  Future<List<SeatVO>>? getSeatingPlanByShowTime(
      String authorizationToken, int cinemaDayTimeId, String bookingDate) {
    return mDataAgent.getSeatingPlanByShowTime(
        authorizationToken, cinemaDayTimeId, bookingDate);
  }

  @override
  void getSnackCategoriesList(
      String authorizationToken) {
     mDataAgent
        .getSnackCategoriesList(authorizationToken)
        ?.then((snackCategoriesList) async {
      mSnackCategoryDao.saveAllSnackCategories(snackCategoriesList);
      // return Future.value(snackCategoriesList);
    });
  }

  @override
  Future<GetCheckOutResponse>? requestCheckout(
      String authorizationToken, CheckOutRequestVO checkoutRequestBody) {
    return mDataAgent.requestCheckout(authorizationToken, checkoutRequestBody);
  }

  /// Database
  @override
  Stream<List<BannerVO>>? getBannersFromDatabase() {
    this.getBanners();
    return mBannerDao
        .getAllBannersEventStream()
        .startWith(mBannerDao.getAllBannersStream())
        .map((event) => mBannerDao.getAllBanners());
  }

  @override
  Future<List<CinemaVO>>? getCinemasFromDatabase() {
    return Future.value(mCinemaDao.getAllCinemas());
  }

  @override
  Stream<List<CityVO>>? getCitiesFromDatabase() {
    this.getCities();
    return mCityDao
        .getAllCitiesEventStream()
        .startWith(mCityDao.getAllCitiesStream())
        .map((event) => mCityDao.getAllCities());
  }

  @override
  Stream<List<MovieVO>>? getNowPlayingMoviesFromDatabase() {
    // return Future.value(mMovieDao.getAllMovies().where((movie) => movie.isNowPlaying ?? true).toList());
    this.getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>>? getCommingSoonMoviesFromDatabase() {
    this.getCommingSoonMovies(1);
    return mMovieDao
        .getCommingSoonMoviesStream()
        .startWith(mMovieDao.getCommingSoonMovies())
        .map((event) => mMovieDao.getCommingSoonMovies());
  }

  @override
  Stream<List<GenreVO>>? getGenresFromDatabase() {
    this.getGenres();
    return mGenreDao
        .getAllGenreEventStream()
        .startWith(mGenreDao.getAllGenersStream())
        .map((event) => mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<PaymentTypeVO>>? getPaymentTypesFromDatabase() {
    this.getPaymentTypes(getLoginUser()?.token ?? "");
    return mPaymentTypeDao
        .getAllPaymentTypeEventStream()
        .startWith(mPaymentTypeDao.getAllPaymentTypeEventStream())
        .map((event) => mPaymentTypeDao.getAllPaymentTypes());
  }

  @override
  Stream<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase() {
    this.getSnackCategoriesList(getLoginUser()?.token ?? "");
    return mSnackCategoryDao
        .getAllSnackCategoriesEventStream()
        .startWith(mSnackCategoryDao.getAllSnackCategoriesStream())
        .map((event) => mSnackCategoryDao.getAllSnackCategories());
  }

  @override
  Stream<List<SnackVO>>? getSnacksListFromDatabase(int? categoryId) {
    this.getSnacksList(getLoginUser()?.token ?? "",null);
    if (categoryId == null) {
      return mSnackDao.getAllSnackEventStream().startWith(mSnackDao.getAllSnacks()).map((event) => mSnackDao.getAllSnacks());
    } else {
      return Stream.value(mSnackDao.getSnacksByCategoryId(categoryId));
    }
  }

  @override
  String getTokenFromDatabase() {
    return "Bearer ${mUserDao.getToken()}";
  }

  @override
  UserVO? getLoginUser() {
    mUserVO = (mUserDao.getAllUsers().isEmpty == false)
        ? mUserDao.getAllUsers().first
        : mUserVO;
    print("login user ${mUserDao.getAllUsers().first.toString()}");
    return mUserVO;
  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(
      String date) {
    return Future.value(mMovieDateTimeSlotsDao
            .getMovieDateTimeSlotsByDate(date)
            ?.cinemaDayTimeSlotsList ??
        []);
  }

  @override
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase() {
    return Future.value(mConfigDataDao.getAllConfigs());
  }
}
