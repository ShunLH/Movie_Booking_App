
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
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
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<CreditVO>>? getCreditsByMovie(int movieId);
  void getCities();
  void getBanners();
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlots();
  Future<BasicResponse>? getOTP(String phNumber);
  Future<SignInResponse>? signInWithPhone(String phNumber,String otp);
  Future<BasicResponse>? signInWithGoogle(String accessToken,String name);
  Future<BasicResponse>? setCity(String authorizationToken,String cityId);
  void getSnacksList(String authorizationToken,int? categoryId);
  void getSnackCategoriesList(String authorizationToken);
  void getPaymentTypes(String authorizationToken);
  Future<List<CinemaVO>>? getCinemasList(String? latestTime);
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(String authorizationToken,String date);
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken,int cinemaDayTimeId,String bookingDate);
  Future<GetCheckOutResponse>? requestCheckout(String authorizationToken,CheckOutRequestVO checkoutRequestBody);


  /// Database
  Stream<List<MovieVO>>? getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>>? getCommingSoonMoviesFromDatabase();
  Stream<List<GenreVO>>? getGenresFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);
  Stream<List<BannerVO>>? getBannersFromDatabase();
  Stream<List<CityVO>>? getCitiesFromDatabase();
  Future<List<CinemaVO>>? getCinemasFromDatabase();
  Stream <List<SnackVO>>? getSnacksListFromDatabase(int? categoryId);
  Stream<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase();
  Stream<List<PaymentTypeVO>>? getPaymentTypesFromDatabase();
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase();
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(String date);
  UserVO? getLoginUser();
  String getTokenFromDatabase();






}