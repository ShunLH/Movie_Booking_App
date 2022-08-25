import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/viewItems/title_text_view.dart';

import '../resources/dimens.dart';
import '../viewItems/app_bar_back_button_view.dart';

class MovieTimePage extends StatelessWidget {
  final List<String> cinemaTypeList = ["2D", "3D", "3D Max", "3D DBox"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.navigation,
              ),
              SizedBox(
                width: MARGIN_SMALL,
              ),
              Text(
                "Yangon",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                ),
              ),
            ],
          ),
        ),
        leading: AppBarBackButtonView(() {
          Navigator.pop(context);
        }),
        actions: [
          Container(
            padding: EdgeInsets.all(MARGIN_SMALL),
            child: Icon(
              Icons.search,
            ),
          ),
          Container(
              padding: EdgeInsets.all(MARGIN_SMALL),
              child: Icon(
                Icons.movie_filter,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: HorizontalMoviePlayingDatesListView(),
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              CinemaTypeSectionView(cinemaTypeList),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              AvaliableStatusSectionView(),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              AvaliableCinemaView(
                  "JCGV:Junction City", () => _navigateToFoodAndBeverageView(context)),
              SepartorLineView(),
              AvaliableCinemaView(
                  "JCGV:City Mall", () => _navigateToFoodAndBeverageView(context)),
              SepartorLineView(),
              AvaliableCinemaView("Mingalar Cinema Gold Clas",
                  () => _navigateToFoodAndBeverageView(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFoodAndBeverageView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => FoodAndBeveragePage(),
    ));
  }
}

class AvaliableCinemaView extends StatefulWidget {
  final String title;
  Function onTappedMovieTime;
  AvaliableCinemaView(this.title, this.onTappedMovieTime);

  @override
  State<AvaliableCinemaView> createState() => _AvaliableCinemaViewState();
}

class _AvaliableCinemaViewState extends State<AvaliableCinemaView> {
  final List<String> _movieTimeList = [
    "9:00 am",
    "12:00 am",
    "1:30 pm",
    "3:30 pm",
    "6:30 pm",
  ];
  bool isShowDetail = false;

  void _onTappedShowDetail() {
    setState(() {
      isShowDetail = !isShowDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CinemaTitleView(widget.title, () {
            _onTappedShowDetail();
          }),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconTextView("Parking", Icons.local_parking_rounded),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                IconTextView("Online Food", Icons.emoji_food_beverage),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                IconTextView("Wheel Chair", Icons.wheelchair_pickup),
              ]),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Visibility(
            visible: this.isShowDetail ? true : false,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  height: AVALIABLE_TIME_GRID_SECTION_HEIGHT,
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: MARGIN_MEDIUM,
                      mainAxisSpacing: MARGIN_MEDIUM,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(Colors.white70,Colors.white10,()=> this.widget.onTappedMovieTime()),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(Colors.white,MOVIE_TIME_GREEN_BORDER_COLOR,()=> this.widget.onTappedMovieTime()),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(Colors.white,MOVIE_TIME_PINK_BORDER_COLOR,()=> this.widget.onTappedMovieTime()),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(Colors.white,MOVIE_TIME_GREEN_BORDER_COLOR,()=> this.widget.onTappedMovieTime()),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(Colors.white,MOVIE_TIME_ORANGE_BORDER_COLOR,()=> this.widget.onTappedMovieTime()),
                        ),

                      ]),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                IconTextView(SEE_SEAT_CLASS_INFO_TEXT, Icons.info_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieTimeView extends StatelessWidget {
  final Color textColor;
  final Color viewColor;
  Function onTappedMoviewTime;

  MovieTimeView(this.textColor,this.viewColor,this.onTappedMoviewTime);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: STATUS_SECTION_COLOR,
          border:
              Border.all(color: viewColor, width: 2.0)),
      child: GestureDetector(
        onTap: (){
          this.onTappedMoviewTime();
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("9 AM",
                  style: TextStyle(
                    color: this.textColor,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Text("3D",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Text("Season 1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Text("2 Avaliable",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
            ]),
      ),
    );
  }
}

class SepartorLineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: STATUS_SECTION_COLOR,
      height: MARGIN_XSMALL,
    );
  }
}

class CinemaTitleView extends StatelessWidget {
  Function onTapSeeDetail;
  final String title;
  CinemaTitleView(this.title, this.onTapSeeDetail);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleTextView(title),
        Spacer(),
        SeeDetailsButtonView(() => this.onTapSeeDetail())
      ],
    );
  }
}

class IconTextView extends StatelessWidget {
  final String title;
  final IconData icon;
  IconTextView(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: ICON_MEDIUM_SIZE,
          color: Colors.white70,
        ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
  }
}

class SeeDetailsButtonView extends StatelessWidget {
  Function onTapSeeDetail;
  SeeDetailsButtonView(this.onTapSeeDetail);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        this.onTapSeeDetail();
      },
      child: Text(
        SEE_DETAILS_TITLE,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: THEME_COLOR,
        ),
      ),
    );
  }
}

class HorizontalMoviePlayingDatesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SCHEDULE_LIST_HEIGHT,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return PlayingDatesView();
          },
        ));
  }
}

class PlayingDatesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.2,
      color: PRIMARY_COLOR,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image.asset(
                "assets/images/Rectangle.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Today",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: TEXT_SMALL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Text(
                  "May",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: TEXT_SMALL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Text(
                  "10",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: TEXT_SMALL,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CinemaTypeSectionView extends StatelessWidget {
  final List<String> cinemaTypeList;

  CinemaTypeSectionView(this.cinemaTypeList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: cinemaTypeList.map((type) => CinemaChipView(type)).toList(),
      ),
    );
  }
}

class CinemaChipView extends StatelessWidget {
  final String textStr;

  CinemaChipView(this.textStr);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
          backgroundColor: Colors.black38,
          label: Text(
            textStr,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}

class AvaliableStatusSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: STATUS_SECTION_COLOR,
      height: AVALIABLE_STATUS_SECTION_HEIGHT,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusView("Avaliable", THEME_COLOR),
          Spacer(),
          StatusView("Filling Fast", Colors.orange),
          Spacer(),
          StatusView("Almost Full", Colors.pink),
        ],
      ),
    );
  }
}

class StatusView extends StatelessWidget {
  final String statusText;
  final Color statusColor;

  StatusView(this.statusText, this.statusColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: statusColor,
          size: MARGIN_CARD_MEDIUM_1,
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Text(
          statusText,
          style: TextStyle(
              color: statusColor,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
