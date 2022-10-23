
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
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getCommingSoonMovies(int page);
  Future<List<GenreVO>>? getGenres();
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<CreditVO>>? getCreditsByMovie(int movieId);
  Future<List<CityVO>>? getCities();
  Future<List<BannerVO>>? getBanners();
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlots();
  Future<BasicResponse>? getOTP(String phNumber);
  Future<SignInResponse>? signInWithPhone(String phNumber,String otp);
  Future<BasicResponse>? signInWithGoogle(String accessToken,String name);
  Future<BasicResponse>? setCity(String authorizationToken,String cityId);
  Future<List<SnackVO>>? getSnacksList(String authorizationToken,int? categoryId);
  Future<List<SnackCategoryVO>>? getSnackCategoriesList(String authorizationToken);
  Future<List<PaymentTypeVO>>? getPaymentTypes(String authorizationToken);
  Future<List<CinemaVO>>? getCinemasList(String? latestTime);
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(String authorizationToken,String date);
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken,int cinemaDayTimeId,String bookingDate);
  Future<GetCheckOutResponse>? requestCheckout(String authorizationToken,CheckOutRequestVO checkoutRequestBody);

  /// Database
  Future<List<MovieVO>>? getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>>? getCommingSoonMoviesFromDatabase();
  Future<List<GenreVO>>? getGenresFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);
  Future<List<BannerVO>>? getBannersFromDatabase();
  Future<List<CityVO>>? getCitiesFromDatabase();
  Future<List<CinemaVO>>? getCinemasFromDatabase();
  Future<List<SnackVO>>? getSnacksListFromDatabase(int? categoryId);
  Future<List<SnackCategoryVO>>? getSnackCategoriesListFromDatabase();
  Future<List<PaymentTypeVO>>? getPaymentTypesFromDatabase();
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlotsFromDatabase();
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDateFromDatabase(String date);
  UserVO? getLoginUser();
  String getTokenFromDatabase();






}