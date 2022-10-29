import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../viewItems/banner_view.dart';
import '../viewItems/movie_view.dart';
import 'movie_detail_page.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MovieModel movieModel = MovieModelImpl();
  List<BannerVO>? mBannerList;
  @override
  void initState() {
    super.initState();
    // movieModel.getBanners()?.then((bannerList) {
    //   setState(() {
    //     this.mBannerList = bannerList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });
    /// Database
    movieModel.getBannersFromDatabase()?.listen((bannerList) {
      setState(() {
        this.mBannerList = bannerList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    movieModel.getCinemasList("")?.then((cinemasList) {
      setState(() {
        // dataRepository.cinemaList = cinemasList;
      });
    });

  /// Database
    movieModel.getCinemasFromDatabase()?.then((cinemasList) {
      setState(() {
        dataRepository.cinemaList = cinemasList;
      });
    });

    movieModel.getConfigsCinemaTimeSlots()?.then((configList) {
      dataRepository.cinemaConfigList = configList;
      List valueList = configList.first.value;
      dataRepository.cinemaTimeSlotStatusList = valueList.map((value) => CinemaTimeSlotStatusVO.fromJson(value)).toList();
      // print(" timeSlots ${dataRepository.cinemaTimeSlotStatusList.toString()}");

    });
    /// Database
    movieModel.getConfigsCinemaTimeSlotsFromDatabase()?.then((configList) {
      dataRepository.cinemaConfigList = configList;
      List valueList = configList.first.value;
      dataRepository.cinemaTimeSlotStatusList = valueList.map((value) => CinemaTimeSlotStatusVO.fromJson(value)).toList();
      // print(" timeSlots ${dataRepository.cinemaTimeSlotStatusList.toString()}");

    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: PRIMARY_COLOR,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              BannerSectionView(mBannerList),
              SizedBox(height: MARGIN_LARGE),
              MovieCategoryTabSectionView((isCommingSoon,movieId)  => _navigateToMovieDetailScreen(context,isCommingSoon,movieId)),
              // SizedBox(height: MARGIN_LARGE),
              // MoviesGridSectionView(true,() => _navigateToMovieDetailScreen(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context,isCommingSoon,movieId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(isCommingSoon: isCommingSoon,movieId: movieId,),
        ));
  }
}

class BannerSectionView extends StatefulWidget {
  final List<BannerVO>? mBannersList;
  BannerSectionView(this.mBannersList);
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  final CarouselController _controller = CarouselController();

  void onPageChange(int index,CarouselPageChangedReason changeReason) {
    setState(() {
      _position = index.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 2.2,
            enlargeCenterPage: true,
            onPageChanged: onPageChange,

          ),
          itemCount: this.widget.mBannersList?.length ?? 0,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              Container(
                child: (this.widget.mBannersList != null) ? BannerView(this.widget.mBannersList?[itemIndex]) : Container(),
              ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        DotsIndicator(
          dotsCount: this.widget.mBannersList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: THEME_COLOR,
          ),
        ),
      ],
    );
  }
}

class MovieCategoryTabSectionView extends StatefulWidget {
  Function(bool,int) onTappedMovie;
  MovieCategoryTabSectionView(this.onTappedMovie);
  @override
  State<MovieCategoryTabSectionView> createState() =>
      _MovieCategoryTabSectionViewState();
}

class _MovieCategoryTabSectionViewState
    extends State<MovieCategoryTabSectionView> {
  var selectedIndex = 0;

  MovieModel? mMovieModel = MovieModelImpl();

  List<MovieVO>? moviesList;

  @override
  void initState() {
    super.initState();
    _getMovieList();
  }

  void _getMovieList(){
    if (selectedIndex == 0){
      // mMovieModel?.getNowPlayingMovies(1)?.then((movieList) {
      //   setState(() {
      //     moviesList = movieList;
      //   });
      // }).catchError((error) {
      //   debugPrint(error.toString());
      // });
      mMovieModel?.getNowPlayingMoviesFromDatabase()?.listen((movieList) {
        setState(() {
          moviesList = movieList;
        });
      }).onError((error) {
        debugPrint(error.toString());
      });
    }else{
      // mMovieModel?.getCommingSoonMovies(1)?.then((movieList) {
      //   setState(() {
      //     moviesList = movieList;
      //   });
      // }).catchError((error) {
      //   debugPrint(error.toString());
      // });
      mMovieModel?.getCommingSoonMoviesFromDatabase()?.listen((movieList) {
        setState(() {
          moviesList = movieList;
        });
      }).onError((error) {
        debugPrint(error.toString());
      });
    }

  }

  void _onSelectTabView(int index) {
    setState(() {
      selectedIndex = index;
      _getMovieList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: DefaultTabController(
            length: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
              padding: EdgeInsets.symmetric(vertical: MARGIN_XSMALL),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(MARGIN_XSMALL)),
                gradient:  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white10,Colors.white24]
                ),
              ),
              child: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.transparent,
                // indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {
                  _onSelectTabView(index);
                },
                tabs: [
                  TabItemView(
                      NOW_PLAYING_TITLE, selectedIndex == 0 ? true : false),
                  TabItemView(
                      COMMING_SOON_TITLE, selectedIndex == 1 ? true : false),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MARGIN_LARGE),
        MoviesGridSectionView(moviesList,selectedIndex == 1 ? true : false,(movieID) => this.widget.onTappedMovie(selectedIndex == 1 ? true : false , movieID)),
      ],
    );
  }
}

class TabItemView extends StatelessWidget {
  final String title;
  final bool isSelected;

  TabItemView(this.title, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: isSelected == true ? THEME_COLOR : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
        // padding: EdgeInsets.all(MARGIN_MEDIUM),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            this.title,
            style: TextStyle(
              color: isSelected == true ? Colors.black : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}

class MoviesGridSectionView extends StatelessWidget {

  final Function(int) onTapMovie;
  final bool isCommingSoon;

  final List<MovieVO>? movieList;

  MoviesGridSectionView(this.movieList,this.isCommingSoon, this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.58,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: movieList?.length ?? 0,
      itemBuilder: (BuildContext context, index) {
        if (this.isCommingSoon == true){
          return MovieView(movieList?[index],isCommingSoon,(movieID) => this.onTapMovie(movieID));
        }else{
          return MovieView(movieList?[index],isCommingSoon,(movieID) => this.onTapMovie(movieID));

        }
      }
    );
  }
}
