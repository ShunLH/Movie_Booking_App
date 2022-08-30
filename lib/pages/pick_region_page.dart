import 'package:flutter/material.dart';
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/movie_time_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../widgets/gradient_view.dart';
import '../widgets/title_text_view.dart';

class PickRegionPage extends StatelessWidget {
  final List<String> citiesList = [
    "Yangon",
    "Mandalay",
    "Naypyidaw",
    "Bago",
    "Mawlamyine"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          PICK_REGION,
          style: TextStyle(
              color: THEME_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Container(
              height: 160,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: LocationSearchBarView(),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: const EdgeInsets.all(MARGIN_MEDIUM),
                        child: LocationImageView()),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: BuildingImageView(),
                  )
                ],
              ),
            ),
            CitiesTitleView(),
            CitiesListView(citiesList,()=>this._navigateToHomePage(context)),
          ],
        ),
      )),
    );
  }
  void _navigateToHomePage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieApp()));
  }
}

class LocationSearchBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(MARGIN_MEDIUM),
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(MARGIN_XSMALL)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white10, Colors.white24]),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_CARD_MEDIUM_1),
            child: Icon(
              Icons.search,
              color: THEME_COLOR,
              size: ICON_MEDIUM_SIZE,
            ),
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Search your location",
                hintStyle: TextStyle(
                  color: DARK_GRAY_TEXT_COLOR,
                ),
                enabled: true,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LocationImageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/location_green.png",
      fit: BoxFit.fitHeight,
      height: 40,
    );
  }
}

class BuildingImageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/illustration_building.png",
      fit: BoxFit.fitWidth,
      width: 100,
    );
  }
}

class CitiesListView extends StatelessWidget {

  final List<String> citiesList;
  Function onTappedCity;
  CitiesListView(this.citiesList,this.onTappedCity);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: citiesList.length,
      itemBuilder: (BuildContext context, int index) {
        return CityListItemView(onTappedCity: onTappedCity, city: citiesList[index]);
      },
    );
  }
}

class CityListItemView extends StatelessWidget {
  const CityListItemView({
    Key? key,
    required this.onTappedCity,
    required this.city,
  }) : super(key: key);

  final Function onTappedCity;
  final String city;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>this.onTappedCity(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: CityTextView(city),
            ),
            SepartorLineView(STATUS_SECTION_COLOR),
          ],
        ),
      ),
    );
  }
}

class CitiesTitleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
              child: GradientView([STATUS_SECTION_COLOR, PRIMARY_COLOR], 0.0)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: TitleTextView("Cities"),
            ),
          )
        ],
      ),
    );
  }
}

class CityTextView extends StatelessWidget {
  final String _title;
  CityTextView(this._title);
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w500),
    );
  }
}
