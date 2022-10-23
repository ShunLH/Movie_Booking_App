import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/checkout_request_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
import 'package:movie_booking_app/network/responses/get_banner_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_and_st_by_date_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_response.dart';
import 'package:movie_booking_app/network/responses/get_city_response.dart';
import 'package:movie_booking_app/network/responses/get_config_response.dart';
import 'package:movie_booking_app/network/responses/get_payment_types_response.dart';
import 'package:movie_booking_app/network/responses/get_seating_plan_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_categories_response.dart';
import 'package:movie_booking_app/network/responses/get_snacks_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_response.dart';
import 'package:retrofit/retrofit.dart';
part 'padc_movie_api.g.dart';

@RestApi(baseUrl: PADC_BASE_URL)
abstract class PadcMovieApi {
  factory PadcMovieApi(Dio dio) = _PadcMovieApi;

  @GET(ENDPOINT_GET_CITIES_LIST)
  Future<GetCityResponse> getCitiesList();

  @GET(ENDPOINT_GET_BANNERS_LIST)
  Future<GetBannerResponse> getBannerList();

  @GET(ENDPOINT_GET_CONFIG_LIST)
  Future<GetConfigResponse> getConfigList();

  @GET(ENDPOINT_GET_CINEMAS_LIST)
  Future<GetCinemaResponse> getCinemasList(
    @Field(PARAM_LATEST_TIME) String? latestTime,
  );

  @GET(ENDPOINT_GET_PAYMENT_TYPES)
  Future<GetPaymentTypesResponse> getPaymentTypes(
    @Header(PARAM_AUTHORIZATION) String bearerToken,
  );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOT)
  Future<GetCinemaAndSTByDateResponse> getCinemaAndShowTimeByDate(
    @Header(PARAM_AUTHORIZATION) String bearerToken,
    @Query(PARAM_DATE) String date,
  );

  @GET(ENDPOINT_GET_SEATING_PLAN_BY_SHOWTIME)
  Future<GetSeatingPlanResponse> getSeatingPlanByShowTime(
    @Header(PARAM_AUTHORIZATION) String bearerToken,
    @Query(PARAM_CINEMAY_DAY_TIMESLOT_ID) int cinemaDayTimeSlotId,
    @Query(PARAM_BOOKING_DATE) String bookingDate,
  );

  @GET(ENDPOINT_GET_SNACK_CATEGORIES)
  Future<GetSnackCategoriesResponse> getSnackCategoriesList(
    @Header(PARAM_AUTHORIZATION) String bearerToken,
  );

  @GET(ENDPOINT_GET_SNACKS_LIST)
  Future<GetSnacksResponse> getSnacksList(
    @Header(PARAM_AUTHORIZATION) String bearerToken,
    @Query(PARAM_CATEGORY_ID) String categoryId,
  );

  @POST(ENDPOINT_GET_OPT)
  Future<BasicResponse>? getOTP(
    @Field(PARAM_PHONE) String phoneNumber,
  );

  @POST(ENDPOINT_SIGN_IN_WITH_PHONE)
  Future<SignInResponse>? signInWithPhone(
    @Field(PARAM_PHONE) String phoneNumber,
    @Field(PARAM_OTP) String otp,
  );

  @POST(ENDPOINT_SIGN_IN_WITH_GOOGLE)
  Future<BasicResponse>? signInWithGoogleAccount(
    @Field(PARAM_ACCESS_TOKEN) String accessToken,
    @Field(PARAM_NAME) String name,
  );

  @POST(ENDPOINT_SET_CITY)
  Future<BasicResponse>? setCity(
      @Header(PARAM_AUTHORIZATION) String bearerToken,
      @Field(PARAM_CITY_ID) String cityID);

  @POST(ENDPOINT_CHECK_OUT)
  Future<GetCheckOutResponse>? requestCheckOut(
      @Header(PARAM_AUTHORIZATION) String bearerToken,
      @Body() CheckOutRequestVO checkoutRequestVO);
}
