import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_request_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
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
import 'package:movie_booking_app/persistence/daos/cinema_timeslot_status_dao.dart';
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
  CinemaTimeSlotStatusDao mTimeSlotStatusDao = CinemaTimeSlotStatusDao();
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
  void getGenres() {
    mDataAgent.getGenres()?.then((genres) async {
      mGenreDao.saveAllGenres(genres);
    });
  }

  @override
  void getMovieDetails(int movieId) {
    mDataAgent.getMovieDetail(movieId)?.then((movie) async {
      MovieVO? movieFromList = mMovieDao.getMovieById(movie.id ?? 0);
      // print("save movie detail ${movieFromList.toString()}");
      movie.isNowPlaying = movieFromList?.isNowPlaying;
      movie.isCommingSoon = movieFromList?.isCommingSoon;
      mMovieDao.saveSingleMovie(movie);
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
  void getCreditsByMovie(int movieId) {
    mDataAgent.getCreditsByMovie(movieId)?.then((creditsList) async {
      MovieVO? mMovie = mMovieDao.getMovieById(movieId);
      mMovie?.creditList = creditsList;
      if (mMovie != null) {
        mMovieDao.saveSingleMovie(mMovie);
      }
      mCreditDao.saveAllCredits(creditsList);
    });
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
  void getConfigsCinemaTimeSlots() {
    mDataAgent.getConfig()?.then((responseList) async {
      mConfigDataDao.saveAllConfigs(responseList);
    });
    mDataAgent
        .getConfig()
        ?.asStream()
        .map((response) => response
            .where((element) => element.key == "cinema_timeslot_status")
            .toList())
        .first;
  }

  @override
  void getConfigCinemaTimeSlotStatus() {
    mDataAgent.getConfig()?.then((responseList) async {
      List<ConfigDataVO>? statusList = responseList
          .where((element) => element.key == "cinema_timeslot_status")
          .toList();
      List valueList = statusList.first.value;
      List<CinemaTimeSlotStatusVO> cinemaTimeSlotStatusList = valueList
          .map((value) => CinemaTimeSlotStatusVO.fromJson(value))
          .toList();
      mTimeSlotStatusDao.saveAllTimeSlotStatus(cinemaTimeSlotStatusList);
    });
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
  void getCinemaAndShowTimeByDate(String authorizationToken, String date) {
    mDataAgent
        .getCinemaAndShowTimeByDate(authorizationToken, date)
        ?.then((timeslotsList) async {
      mMovieDateTimeSlotsDao.saveSingleMovieDateTimeSlotDaoByDate(
          MovieDateTimeSlotsVO(date, timeslotsList));
      // return Future.value(timeslotsList);
    });
  }

  @override
  void getCinemasList(String? latestTime) {
    mDataAgent.getCinemasList(latestTime)?.then((cinemaList) async {
      mCinemaDao.saveAllCinemas(cinemaList);
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
  void getSnackCategoriesList(String authorizationToken) {
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
  Stream<List<CinemaVO>>? getCinemasFromDatabase() {
    this.getCinemasList(null);
    return mCinemaDao
        .getAllCinemasEventStream()
        .startWith(mCinemaDao.getAllCinemasStream())
        .map((event) => mCinemaDao.getAllCinemas());
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
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Stream.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<PaymentTypeVO>>? getPaymentTypesFromDatabase() {
    this.getPaymentTypes(this.getTokenFromDatabase());
    return mPaymentTypeDao
        .getAllPaymentTypeEventStream()
        .startWith(mPaymentTypeDao.getAllPaymentTypeEventStream())
        .map((event) => mPaymentTypeDao.getAllPaymentTypes());
  }

  @override
  Stream<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase() {
    this.getSnackCategoriesList(this.getTokenFromDatabase());
    return mSnackCategoryDao
        .getAllSnackCategoriesEventStream()
        .startWith(mSnackCategoryDao.getAllSnackCategoriesStream())
        .map((event) => mSnackCategoryDao.getAllSnackCategories());
  }

  @override
  Stream<List<SnackVO>>? getSnacksListFromDatabase(int? categoryId) {
    this.getSnacksList(this.getTokenFromDatabase(), null);
    if (categoryId == null || categoryId == 0){
      print("categoryId ${categoryId}");
      return Stream.value(mSnackDao.getAllSnacks());
      // return mSnackDao
      //     .getAllSnackEventStream()
      //     .startWith(mSnackDao.getAllSnacksStream())
      // .map((event) {
      //   if  (categoryId == null) {
      //     return mSnackDao.getAllSnacks();
      //   }else{
      //     return mSnackDao.getSnacksByCategoryId(categoryId);
      //   }
      // });
      //     .map((event) => mSnackDao.getAllSnacks());
    } else {
      print("categoryId not null ${categoryId}");

      return Stream.value(mSnackDao.getSnacksByCategoryId(categoryId));
      // return mSnackDao
      //     .getAllSnackEventStream()
      //     .startWith(mSnackDao.getAllSnacksByIdStream(categoryId))
      //     .map((event) => mSnackDao.getSnacksByCategoryId(categoryId));
    }
  }

  @override
  String getTokenFromDatabase() {
    return "Bearer ${mUserDao.getToken()}";
  }

  @override
  UserVO? getLoginUser() {
    mUserVO = (mUserDao.getAllUsers().isEmpty == false)
        ? mUserDao.getAllUsers()?.first
        : mUserVO;
    print("login user ${mUserDao.getAllUsers().first.toString()}");
    // getLoginUserReactive().listen((user) {
    //   print("login user ${user.toString()}");
    //   mUserVO = user;
    // });
    return mUserVO;
  }

  @override
  Stream<UserVO?> getLoginUserReactive() {
    return mUserDao
        .getAllUserEventStream()
        .startWith(mUserDao.getAllUsersStream())
        .map((event) => mUserDao.getAllUsers().first);
  }

  @override
  Stream<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(
      String date) {
    this.getCinemaAndShowTimeByDate(this.getTokenFromDatabase(), date);
    return mMovieDateTimeSlotsDao
        .getAllMovieDateTimeSlotsByDateEventStream()
        .startWith(mMovieDateTimeSlotsDao.getMovieDateTimeSlotsStream())
        .map((event) =>
            mMovieDateTimeSlotsDao
                .getMovieDateTimeSlotsByDate(date)
                ?.cinemaDayTimeSlotsList ??
            []);
    // return Stream.value(mMovieDateTimeSlotsDao
    //         .getMovieDateTimeSlotsByDate(date)
    //         ?.cinemaDayTimeSlotsList ??
    //     []);
  }

  @override
  Stream<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase() {
    this.getConfigsCinemaTimeSlots();
    return mConfigDataDao
        .getAllConfigsEventStream()
        .startWith(mConfigDataDao.getAllConfigDataStream())
        .map((event) => mConfigDataDao.getAllConfigs());
  }

  @override
  Stream<List<CinemaTimeSlotStatusVO>>?
      getConfigCinemaTimeSlotStatusFromDatabase() {
    this.getConfigCinemaTimeSlotStatus();
    return mTimeSlotStatusDao
        .getAllTimeSlotsStatusEventStream()
        .startWith(mTimeSlotStatusDao.getAllTimeSlotStatusStream())
        .map((event) => mTimeSlotStatusDao.getAllTimeSlotsStatus());
  }

  @override
  Stream<List<CreditVO>>? getCreditsByMovieFromDatabase(int movieId) {
    this.getCreditsByMovie(movieId);
    return mCreditDao
        .getAllCreditsEventStream()
        .startWith(mCreditDao.getAllCreditsStream())
        .map((event) => mMovieDao.getMovieById(movieId)?.creditList ?? []);
  }
}
