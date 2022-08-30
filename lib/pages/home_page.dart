import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      child: SingleChildScrollView(
        child: Container(
          color: PRIMARY_COLOR,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              BannerSectionView(),
              SizedBox(height: MARGIN_LARGE),
              MovieCategoryTabSectionView((isCommingSoon)  => _navigateToMovieDetailScreen(context,isCommingSoon)),
              // SizedBox(height: MARGIN_LARGE),
              // MoviesGridSectionView(true,() => _navigateToMovieDetailScreen(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context,isCommingSoon) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(isCommingSoon),
        ));
  }
}

class BannerSectionView extends StatefulWidget {
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
          itemCount: 5,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              Container(
                child: BannerView(),
              ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        DotsIndicator(
          dotsCount: 5,
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
  Function(bool) onTappedMovie;
  MovieCategoryTabSectionView(this.onTappedMovie);
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
        MoviesGridSectionView(selectedIndex == 1 ? true : false,() => this.widget.onTappedMovie(selectedIndex == 1 ? true : false)),
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
  final List<String> _commingSoonItem = [
    movie2,
    movie3,
    movie1,
    movie2,
    movie4,
    movie3,
    movie2,
  ];
  final Function onTapMovie;
  final bool isCommingSoon;

  MoviesGridSectionView(this.isCommingSoon, this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: this.isCommingSoon ? _commingSoonItem.length : _listItem.length,
      itemBuilder: (BuildContext context, index) {
        if (this.isCommingSoon == true){
          return MovieView(_commingSoonItem[index],isCommingSoon,() => this.onTapMovie());
        }else{
          return MovieView(_listItem[index],isCommingSoon,() => this.onTapMovie());

        }
      }
    );
  }
}
