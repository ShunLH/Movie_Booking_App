
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

}