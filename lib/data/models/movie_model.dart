
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/data/vos/config_data_vo.dart';
import 'package:movie_booking_app/data/vos/credit_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/data/vos/seat_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_response.dart';

import '../../network/responses/get_checkout_response.dart';
import '../vos/checkout_request_vo.dart';
import '../vos/ticket_vo.dart';
import '../vos/user_vo.dart';

abstract class MovieModel {
  void getNowPlayingMovies(int page);
  void getCommingSoonMovies(int page);
  void getGenres();
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);
  void getCities();
  void getBanners();
  void getConfigsCinemaTimeSlots();
  Future<BasicResponse>? getOTP(String phNumber);
  Future<SignInResponse>? signInWithPhone(String phNumber,String otp);
  Future<BasicResponse>? signInWithGoogle(String accessToken,String name);
  Future<BasicResponse>? setCity(String authorizationToken,String cityId);
  void getSnacksList(String authorizationToken,int? categoryId);
  void getSnackCategoriesList(String authorizationToken);
  void getPaymentTypes(String authorizationToken);
  void getCinemasList(String? latestTime);
  void getCinemaAndShowTimeByDate(String authorizationToken,String date);
  void getConfigCinemaTimeSlotStatus();
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken,int cinemaDayTimeId,String bookingDate);
  Future<GetCheckOutResponse>? requestCheckout(String authorizationToken,CheckOutRequestVO checkoutRequestBody);


  /// Database
  Stream<List<MovieVO>>? getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>>? getCommingSoonMoviesFromDatabase();
  Stream<List<GenreVO>>? getGenresFromDatabase();
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);
  Stream<List<BannerVO>>? getBannersFromDatabase();
  Stream<List<CityVO>>? getCitiesFromDatabase();
  Stream<List<CinemaVO>>? getCinemasFromDatabase();
  Stream <List<SnackVO>>? getSnacksListFromDatabase(int? categoryId);
  Stream<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase();
  Stream<List<PaymentTypeVO>>? getPaymentTypesFromDatabase();
  Stream<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase();
  Stream<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(String date);
  Stream<List<CinemaTimeSlotStatusVO>>? getConfigCinemaTimeSlotStatusFromDatabase();
  Stream<List<CreditVO>>? getCreditsByMovieFromDatabase(int movieId);
  Stream<UserVO?> getLoginUserReactive();
  UserVO? getLoginUser();
  String getTokenFromDatabase();






}