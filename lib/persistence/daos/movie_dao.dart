
import 'package:hive/hive.dart';

import '../../data/vos/movie_vo.dart';
import '../hive_constants.dart';

class MovieDao{
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int,MovieVO> movieMap = Map.fromIterable(movies,key:(movie) => movie.id,value:(movie)=>movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id,movie);
  }

  List<MovieVO> getAllMovies(){
    List<MovieVO> movieListFromDatabase = getMovieBox().values.toList();
    movieListFromDatabase.forEach((element) => print(element.title));
    return movieListFromDatabase;
  }

  MovieVO? getMovieById(int movieId){
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isNowPlaying ?? false).toList();
    } else {
      return [];
    }
  }
  List<MovieVO> getCommingSoonMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element?.isCommingSoon ?? false).toList();
    } else {
      return [];
    }
  }
  /// Reactive Programming

  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element?.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getCommingSoonMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element?.isCommingSoon ?? false)
        .toList());
  }

}