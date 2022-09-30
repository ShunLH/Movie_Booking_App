

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
import 'package:movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_response.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page);
  }
  @override
  Future<List<GenreVO>>? getGenres() {
    return mDataAgent.getGenres();
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetail(movieId);
  }

  @override
  Future<List<MovieVO>>? getCommingSoonMovies(int page) {
    return mDataAgent.getCommingSoonMovies(page);
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<List<BannerVO>>? getBanners() {
    return mDataAgent.getBanners();
  }

  @override
  Future<List<CityVO>>? getCities() {
    return mDataAgent.getCities();
  }

  @override
  Future<List<ConfigDataVO>>? getConfigsCinemaTimeSlots() {
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
    return mDataAgent.postSignInWithPhone(phNumber, otp);

  }

  @override
  Future<List<SnackVO>>? getSnacksList(String authorizationToken, int? categoryId) {
    print("Cate ${categoryId}");
    return mDataAgent.getSnacksList(authorizationToken, categoryId);

  }

  @override
  Future<BasicResponse>? setCity(String authorizationToken, String cityId) {
    return mDataAgent.setCity(authorizationToken, cityId);

  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(String authorizationToken, String date) {
    return mDataAgent.getCinemaAndShowTimeByDate(authorizationToken, date);

  }

  @override
  Future<List<CinemaVO>>? getCinemasList(String? latestTime) {
    return mDataAgent.getCinemasList(latestTime);
  }

  @override
  Future<List<PaymentTypeVO>>? getPaymentTypes(String authorizationToken) {
    return mDataAgent.getPaymentTypes(authorizationToken);
  }

  @override
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken, int cinemaDayTimeId, String bookingDate) {
    return mDataAgent.getSeatingPlanByShowTime(authorizationToken, cinemaDayTimeId, bookingDate);
  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategoriesList(String authorizationToken) {
    return mDataAgent.getSnackCategoriesList(authorizationToken);
  }

}