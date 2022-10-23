

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


  factory MovieModelImpl(){
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
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isCommingSoon = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      return Future.value(movies);
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
    return mDataAgent.getMovieDetail(movieId)?.then((movie) async{
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  @override
  Future<List<MovieVO>>? getCommingSoonMovies(int page) {
    return mDataAgent.getCommingSoonMovies(page)?.then((movies) async {
      List<MovieVO> commingSoonMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isCommingSoon = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(commingSoonMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<List<BannerVO>>? getBanners() {
    return mDataAgent.getBanners()?.then((bannersList) async{
      mBannerDao.saveAllBanners(bannersList);
      return Future.value(bannersList);
    });
  }

  @override
  Future<List<CityVO>>? getCities() {
    return mDataAgent.getCities()?.then((citiesList) async{
      mCityDao.saveAllCities(citiesList);
      return Future.value(citiesList);
    });
  }

  @override
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlots() {
     mDataAgent.getConfig()?.then((responseList) async{
      mConfigDataDao.saveAllConfigs(responseList);
    });
    return mDataAgent.getConfig()?.asStream().map((response) => response.where((element) => element.key == "cinema_timeslot_status").toList()).first;
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
    return mDataAgent.postSignInWithPhone(phNumber, otp)?.then((response) async{
      UserVO? userVO = response.data;
      userVO?.token = response.token;
      if (userVO != null) {
        mUserDao.saveUser(userVO!);

      }
      return Future.value(response);
    });

  }

  @override
  Future<List<SnackVO>>? getSnacksList(String authorizationToken, int? categoryId) {
    print("Cate ${categoryId}");
    return mDataAgent.getSnacksList(authorizationToken, categoryId)?.then((snacksList) async{
      mSnackDao.saveAllSnacks(snacksList);
      return Future.value(snacksList);
    });

  }

  @override
  Future<BasicResponse>? setCity(String authorizationToken, String cityId) {
    UserVO? mUserVO = getLoginUser();
    if (mUserVO != null) {
      print("Savingg city cityID ==> ${cityId} ===> ${mCityDao.getAllCities().toString()}");
      mUserVO?.selectedCity = mCityDao.getCityById(int.parse(cityId));
      print("City Query ${mCityDao.getCityById(cityId)}");
      print("update user ${mUserVO.toString()}");
      mUserDao.saveUser(mUserVO!);
    }
    return mDataAgent.setCity(authorizationToken, cityId);

  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(String authorizationToken, String date) {
    return mDataAgent.getCinemaAndShowTimeByDate(authorizationToken, date)?.then((timeslotsList) async{
      mMovieDateTimeSlotsDao.saveSingleMovieDateTimeSlotDaoByDate(MovieDateTimeSlotsVO(date, timeslotsList));
      return Future.value(timeslotsList);
    });

  }

  @override
  Future<List<CinemaVO>>? getCinemasList(String? latestTime) {
    return mDataAgent.getCinemasList(latestTime)?.then((cinemaList) async{
      mCinemaDao.saveAllCinemas(cinemaList);
      return Future.value(cinemaList);
    });
  }

  @override
  Future<List<PaymentTypeVO>>? getPaymentTypes(String authorizationToken) {
    return mDataAgent.getPaymentTypes(authorizationToken)?.then((paymentTypesList) async{
      mPaymentTypeDao.saveAllPaymentTypes(paymentTypesList);
      return Future.value(paymentTypesList);
    });
  }

  @override
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken, int cinemaDayTimeId, String bookingDate) {
    return mDataAgent.getSeatingPlanByShowTime(authorizationToken, cinemaDayTimeId, bookingDate);
  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategoriesList(String authorizationToken) {
    return mDataAgent.getSnackCategoriesList(authorizationToken)?.then((snackCategoriesList) async{
      mSnackCategoryDao.saveAllSnackCategories(snackCategoriesList);
      return Future.value(snackCategoriesList);
    });
  }

  @override
  Future<GetCheckOutResponse>? requestCheckout(String authorizationToken, CheckOutRequestVO checkoutRequestBody) {
    return mDataAgent.requestCheckout(authorizationToken, checkoutRequestBody);
  }

  /// Database
  @override
  Future<List<BannerVO>>? getBannersFromDatabase() {
    return Future.value(mBannerDao.getAllBanners());

  }

  @override
  Future<List<CinemaVO>>? getCinemasFromDatabase() {
    return Future.value(mCinemaDao.getAllCinemas());

  }

  @override
  Future<List<CityVO>>? getCitiesFromDatabase() {
    return Future.value(mCityDao.getAllCities());

  }

  @override
  Future<List<MovieVO>>? getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao.getAllMovies().where((movie) => movie.isNowPlaying ?? true).toList());

  }

  @override
  Future<List<MovieVO>>? getCommingSoonMoviesFromDatabase() {
    return Future.value(mMovieDao.getAllMovies().where((movie) => movie.isCommingSoon ?? true).toList());

  }

  @override
  Future<List<GenreVO>>? getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }


  @override
  Future<List<PaymentTypeVO>>? getPaymentTypesFromDatabase() {
    return Future.value(mPaymentTypeDao.getAllPaymentTypes());

  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase() {
    return Future.value(mSnackCategoryDao.getAllSnackCategories());

  }

  @override
  Future<List<SnackVO>>? getSnacksListFromDatabase(int? categoryId) {
    if (categoryId == null) {
      return Future.value(mSnackDao.getAllSnacks());
    }else{
      return Future.value(mSnackDao.getSnacksByCategoryId(categoryId));

    }
  }

  @override
  String getTokenFromDatabase() {
    return "Bearer ${mUserDao.getToken()}";
  }

  @override
  UserVO? getLoginUser() {
    mUserVO = (mUserDao.getAllUsers().isEmpty == false) ? mUserDao.getAllUsers().first : mUserVO;
    print("login user ${mUserDao.getAllUsers().first.toString()}");
    return mUserVO;
  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(String date) {
    return Future.value(mMovieDateTimeSlotsDao.getMovieDateTimeSlotsByDate(date)?.cinemaDayTimeSlotsList ?? []);
  }

  @override
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase() {
    return  Future.value(mConfigDataDao.getAllConfigs());
  }



}