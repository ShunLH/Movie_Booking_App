import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../assets.dart';
import '../viewItems/banner_view.dart';
import '../viewItems/movie_view.dart';
import 'movie_detail_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: PRIMARY_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            BannerSectionView(),
            SizedBox(height: MARGIN_LARGE),
            MovieCategoryTabSectionView(),
            SizedBox(height: MARGIN_LARGE),
            MoviesGridSectionView(() => _navigateToMovieDetailScreen(context)),
          ],
        ),
      ),
    );
  }
  void _navigateToMovieDetailScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MovieDetailsPage(),
    ));
  }
}

class BannerSectionView extends StatefulWidget {

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.5,
          child: PageView(
              onPageChanged: (page) {
                setState(() {
                  _position = page.toDouble();
                });
              },
              children: [
                BannerView(),
                BannerView(),
                BannerView(),
                BannerView(),
              ]),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        DotsIndicator(
          dotsCount: 4,
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

  @override
  State<MovieCategoryTabSectionView> createState() =>
      _MovieCategoryTabSectionViewState();
}

class _MovieCategoryTabSectionViewState
    extends State<MovieCategoryTabSectionView> {
  var selectedIndex = 0;


  void _onSelectTabView(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Container(
          color: Colors.white10,
          margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
          child: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
            // indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) {
              _onSelectTabView(index);
            },
            tabs: [
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedIndex == 0 ? THEME_COLOR : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))
                  ),
                  // padding: EdgeInsets.all(MARGIN_MEDIUM),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      NOW_PLAYING_TITLE,
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.black : Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: selectedIndex == 1 ? THEME_COLOR : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))
                  ),
                  // padding: EdgeInsets.all(MARGIN_MEDIUM),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      COMMING_SOON_TITLE,
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.black : Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviesGridSectionView extends StatelessWidget {
  final List<String> _listItem = [
    movie1,
    movie2,
    movie3,
    movie4,
    movie1,
    movie2,
    movie3,
    movie4,
  ];
  final Function onTapMovie;

  MoviesGridSectionView(this.onTapMovie);


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.7,
      children: _listItem.map((item) => MovieView(item, (){
        this.onTapMovie();
      })).toList(),
    ));
  }
}
