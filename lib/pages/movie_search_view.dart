import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/pick_region_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../assets.dart';
import '../viewItems/movie_view.dart';

class MovieSearchView extends StatelessWidget {
  final List<String> filterTypeList = ["Genres", "Format", "Month"];
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
              MoviesResultGridSectionView(()=>{}),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterTypeView extends StatelessWidget {
  final String title;
  @override
  FilterTypeView(this.title);
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      padding: EdgeInsets.all(MARGIN_SMALL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RegularNormalTextView(this.title, Colors.black),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: ICON_MEDIUM_SIZE,
              )),
        ],
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
  final List<String> _listItem = [
    movie2,
    movie3,
    movie4,

  ];

  final Function onTapMovie;

  MoviesResultGridSectionView(this.onTapMovie);

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
        itemCount: _listItem.length,
        itemBuilder: (BuildContext context, index) {
          return MovieView(_listItem[index], false, () => this.onTapMovie());
        });
  }
}
