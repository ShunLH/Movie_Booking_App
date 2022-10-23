
import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_request_vo.dart';
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
import 'package:movie_booking_app/data/vos/ticket_vo.dart';
import 'package:movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_booking_app/network/padc_movie_api.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_response.dart';
import 'package:movie_booking_app/network/the_movie_api.dart';

import '../api_constants.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  PadcMovieApi? padcApi;

  static final RetrofitDataAgentImpl _singleton =
  RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    // final dio = Dio();
    final dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
        headers: {
          HEADER_REQUESTED_WITH: XML_HTTP_REQUEST,
        },
      ),
    );
    mApi = TheMovieApi(dio);
    padcApi = PadcMovieApi(dio);
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        ?.asStream()
        .map((response) => response.results ?? [])
        .first;

  }

  @override
  Future<List<MovieVO>>? getCommingSoonMovies(int page) {
    return mApi
        .getCommingSoonMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        ?.asStream()
        .map((response) => response.results ?? [])
        .first;

  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        ?.asStream()
        .map((response) => response.genres ?? [])
        .first;
  }

  @override
  Future<MovieVO>? getMovieDetail(int movieId) {
    return mApi
        .getMovieDetail(movieId.toString(), API_KEY, LANGUAGE_EN_US, "1")
        ?.asStream()
        .map((response) => response)
        .first;
  }
  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(movieId.toString(), API_KEY, LANGUAGE_EN_US, "1")
        .asStream()
        .map((respones) => respones.cast ?? [])
        .first;
  }

  @override
  Future<List<BannerVO>>? getBanners() {
    return padcApi?.getBannerList().asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<CityVO>>? getCities() {
    return padcApi?.getCitiesList().asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<ConfigDataVO>>? getConfig() {
    return padcApi?.getConfigList().asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<BasicResponse>? getOTP(String phNumber) {
    return padcApi?.getOTP(phNumber)?.asStream().map((responses) => responses).first;
  }

  @override
  Future<BasicResponse>? postSignInWithGoogle(String accessToken, String name) {
    return padcApi?.signInWithGoogleAccount(accessToken,name)?.asStream().map((responses) => responses).first;

  }

  @override
  Future<SignInResponse>? postSignInWithPhone(String phNumber, String otp) {
    return padcApi?.signInWithPhone(phNumber,otp)?.asStream().map((responses) => responses).first;
  }

  @override
  Future<List<SnackVO>>? getSnacksList(String authorizationToken, int? categoryId) {
    return padcApi?.getSnacksList(authorizationToken, (categoryId!= null) ? "${categoryId}" : "").asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<BasicResponse>? setCity(String authorizationToken, String cityId) {
      return padcApi?.setCity(authorizationToken,cityId)?.asStream().map((responses) => responses).first;
  }

  @override
  Future<List<CinemaDayTimeslotsVO>>? getCinemaAndShowTimeByDate(String authorizationToken, String date) {
    return padcApi?.getCinemaAndShowTimeByDate(authorizationToken,date).asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<CinemaVO>>? getCinemasList(String? latestTime) {
    return padcApi?.getCinemasList(latestTime).asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<PaymentTypeVO>>? getPaymentTypes(String authorizationToken) {
    return padcApi?.getPaymentTypes(authorizationToken).asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<SeatVO>>? getSeatingPlanByShowTime(String authorizationToken, int cinemaDayTimeId, String bookingDate) {
    return padcApi?.getSeatingPlanByShowTime(authorizationToken,cinemaDayTimeId,bookingDate).asStream().map((responses) => responses.data ?? []).first;
  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategoriesList(String authorizationToken) {
    return padcApi?.getSnackCategoriesList(authorizationToken).asStream().map((responses) => responses.data ?? []).first;

  }

  @override
  Future<GetCheckOutResponse>? requestCheckout(String authorizationToken, CheckOutRequestVO checkoutRequestBody) {
    return padcApi?.requestCheckOut(authorizationToken, checkoutRequestBody)?.asStream().map((responses) => responses).first;
  }

}