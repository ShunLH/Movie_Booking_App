import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../widgets/gradient_view.dart';
import '../widgets/separator_line_view.dart';
import '../widgets/title_text_view.dart';

class PickRegionPage extends StatefulWidget {
  @override
  State<PickRegionPage> createState() => _PickRegionPageState();

}

class _PickRegionPageState extends State<PickRegionPage> {
  MovieModel movieModel = MovieModelImpl();
  DataRepository dataRepository = DataRepository();
  List<CityVO>? citiesList;

  @override
  void initState() {
    super.initState();
    //     movieModel.getCities()?.then((cities) {
    //   setState(() {
    //     this.citiesList = cities;
    //   });
    // }).catchError((error) => debugPrint(error.toString()));
    /// Database
    movieModel.getCitiesFromDatabase()?.listen((cities) {
      setState(() {
        this.citiesList = cities;
      });
    }).onError((error) => debugPrint(error.toString()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          PICK_REGION,
          style: TextStyle(
              color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
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
            CitiesListView(citiesList,(cityId)=>this._navigateToHomePage(context,cityId)),
          ],
        ),
      )),
    );
  }

  void _navigateToHomePage(BuildContext context,cityId){
    if (citiesList != null) {
      CityVO selectedCity = citiesList!.where((city) => city.id == cityId).first;
      dataRepository.location = selectedCity;
      String bearerToken = movieModel.getTokenFromDatabase();
      print("Token $bearerToken");

      movieModel.setCity(bearerToken, "${cityId}")?.then((response){
        if(response.code == 200){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieApp(city: selectedCity)));
        }
      });

    }
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
              color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
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

  final List<CityVO>? citiesList;
  Function(int) onTappedCity;
  CitiesListView(this.citiesList,this.onTappedCity);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: citiesList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return CityListItemView(onTappedCity: onTappedCity, city: citiesList?[index]);
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
  final CityVO? city;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>this.onTappedCity(city?.id ?? 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: CityTextView(city?.name ?? ""),
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
