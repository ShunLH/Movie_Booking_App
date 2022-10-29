import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/filter_type_view.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../viewItems/movie_view.dart';

class MovieSearchView extends StatefulWidget {
  @override
  State<MovieSearchView> createState() => _MovieSearchViewState();

}

class _MovieSearchViewState extends State<MovieSearchView> {
  final List<String> filterTypeList = ["Genres", "Format", "Month"];
  MovieModel? mMovieModel = MovieModelImpl();

  List<MovieVO>? movieResultList;
  List<GenreVO>? movieGenresList;

  @override
  void initState() {
    super.initState();
    mMovieModel?.getNowPlayingMoviesFromDatabase()?.listen((movieList){
      setState(() {
        movieResultList = movieList;
      });
    });

    mMovieModel?.getGenresFromDatabase()?.listen((genreList) {
      setState(() {
        movieGenresList = genreList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: PRIMARY_COLOR,
        title: MovieSearchBarView(),
        actions: [
          GestureDetector(
              onTap: () => {},
              child: Image.asset(
                "assets/images/filter_green.png",
                width: ICON_MEDIUM_SIZE,
                height: ICON_MEDIUM_SIZE,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(MARGIN_SMALL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: MARGIN_MEDIUM,
                children:
                    filterTypeList.map((item) => FilterTypeView(item)).toList(),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              MoviesResultGridSectionView(movieResultList,(movieId)=>{}),
            ],
          ),
        ),
      ),
    );
  }
}


class MovieSearchBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MARGIN_MEDIUM),
      width: 260,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.search,
            color: DARK_GRAY_TEXT_COLOR,
            size: ICON_MEDIUM_SIZE,
          ),
          SizedBox(width: MARGIN_SMALL),
          Container(
            width: 180,
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Search the movie",
                hintStyle: TextStyle(
                  color: GRAY_TEXT_COLOR,
                ),
                enabled: true,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoviesResultGridSectionView extends StatelessWidget {
  // final List<String> _listItem = [
  //   movie2,
  //   movie3,
  //   movie4,
  //
  // ];

  final List<MovieVO>? movieList;

  final Function(int) onTapMovie;

  MoviesResultGridSectionView(this.movieList,this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: movieList?.length ?? 0,
        itemBuilder: (BuildContext context, index) {
          return MovieView(movieList?[index], false, (movieID) => this.onTapMovie(movieID));
        });
  }
}
