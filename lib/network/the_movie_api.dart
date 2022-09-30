import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/responses/get_credits_by_movie_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'package:retrofit/http.dart';

import 'responses/get_genres_response.dart';
import 'responses/movie_list_response.dart';
part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{

  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse>? getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,

  );

  @GET(ENDPOINT_GET_COMMING_SOON_MOVIES)
  Future<MovieListResponse>? getCommingSoonMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,

      );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenresResponse>? getGenres(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );

  @GET('$ENDPOINT_GET_MOVIE_DETAIL/{movie_id}')
  Future<MovieVO>? getMovieDetail(
      @Path('movie_id') String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET('$ENDPOINT_GET_CREDITS_BY_MOVIE/{movie_id}/credits')
  Future<GetCreditsByMovieResponse> getCreditsByMovie(
      @Path('movie_id') String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

}