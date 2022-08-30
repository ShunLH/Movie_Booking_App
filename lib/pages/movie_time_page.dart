import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../resources/dummy.dart';
import '../resources/dimens.dart';
import '../viewItems/playing_dates_view.dart';
import '../widgets/app_bar_back_button_view.dart';
import '../widgets/icon_text_view.dart';

class MovieTimePage extends StatelessWidget {
  final List<String> cinemaTypeList = ["2D", "3D", "3D Max", "3D DBox"];
  final List<String> cinemaList = [
    "JCGV:Junction City",
    "JCGV:City Mall",
    "Mingalar Cinema Gold Class"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Container(
          child: LocationView("Yangon"),
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
            child: ImageIcon(AssetImage("assets/images/filter_white.png")),
          ),
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
              SizedBox(height: MARGIN_MEDIUM),
              CinemaTypeSectionView(cinemaTypeList),
              SizedBox(height: MARGIN_MEDIUM),
              AvaliableStatusSectionView(),
              SizedBox(height: MARGIN_MEDIUM),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cinemaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            AvaliableCinemaView(cinemaList[index],
                                () => _navigateToFoodAndBeverageView(context)),
                            Visibility(
                              visible:
                                  index < cinemaList.length - 1 ? true : false,
                              child: SepartorLineView(Colors.white70),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFoodAndBeverageView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodAndBeveragePage(),
        ));
  }
}

class LocationView extends StatelessWidget {
  final String locationName;
  LocationView(this.locationName);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ImageIcon(AssetImage("assets/images/navigation_white.png")),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          this.locationName,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
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
                IconTextView("Parking", "parking_white.png"),
                SizedBox(width: MARGIN_MEDIUM),
                IconTextView("Online Food", "fnb_icon.png"),
                SizedBox(width: MARGIN_MEDIUM),
                IconTextView("Wheel Chair", "wheelchair_white.png"),
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
                  child: Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movieTimeSlotList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                          child: MovieTimeView(movieTimeSlotList[index],
                              () => this.widget.onTappedMovieTime()),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                IconTextView(SEE_SEAT_CLASS_INFO_TEXT, "info_icon.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieTimeView extends StatelessWidget {

  final MovieTimeSlotVO movieTimeSlot;
  Function onTappedMoviewTime;

  Color _getBackgroundColor(AvaliableStatus status){
    Color bgColor = PRIMARY_COLOR;
    switch (status) {
      case AvaliableStatus.ALMOST_FULL :
        bgColor = MOVIE_TIME_PINK_BORDER_COLOR;
        break;
      case AvaliableStatus.AVALIABLE :
        bgColor = MOVIE_TIME_GREEN_BORDER_COLOR;
        break;
      case AvaliableStatus.FILLING_FAST :
        bgColor = MOVIE_TIME_ORANGE_BORDER_COLOR;
        break;
      case AvaliableStatus.NOT_AVALIABLE :
        bgColor = STATUS_SECTION_COLOR;
        break;
    }
    return bgColor;
  }

  MovieTimeView(this.movieTimeSlot,this.onTappedMoviewTime);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTappedMoviewTime(),
      child: Container(
        decoration: BoxDecoration(
            color: _getBackgroundColor(this.movieTimeSlot.avaliableStatus).withOpacity(0.15),
            border: Border.all(color: _getBackgroundColor(this.movieTimeSlot.avaliableStatus), width: 2.0)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(this.movieTimeSlot.time,
                  style: TextStyle(
                    color: this.movieTimeSlot.avaliableStatus == AvaliableStatus.NOT_AVALIABLE ? GRAY_TEXT_COLOR : Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Text(this.movieTimeSlot.cinemaType,
                  style: TextStyle(
                    color: this.movieTimeSlot.avaliableStatus == AvaliableStatus.NOT_AVALIABLE ? GRAY_TEXT_COLOR : Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Text(this.movieTimeSlot.screenType,
                  style: TextStyle(
                    color: this.movieTimeSlot.avaliableStatus == AvaliableStatus.NOT_AVALIABLE ? GRAY_TEXT_COLOR : Colors.white,
                    fontSize: TEXT_REGULAR,
                  )),
              SizedBox(height: MARGIN_XSMALL),
              Visibility(
                visible: this.movieTimeSlot.avaliableCount > 0 ? true : false,
                child: Text("2 Avaliable",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR,
                    )),
              ),
            ]),
      ),
    );
  }
}

class SepartorLineView extends StatelessWidget {
  final Color lineColor;
  SepartorLineView(@required this.lineColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lineColor,
      height: MARGIN_LINE_1,
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

class HorizontalMoviePlayingDatesListView extends StatefulWidget {
  @override
  State<HorizontalMoviePlayingDatesListView> createState() =>
      _HorizontalMoviePlayingDatesListViewState();
}

class _HorizontalMoviePlayingDatesListViewState
    extends State<HorizontalMoviePlayingDatesListView> {
  int selectedIndex = 0;

  void _onTappedSelectd(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SCHEDULE_LIST_HEIGHT,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieDateList.length,
          itemBuilder: (BuildContext context, int index) {
            return PlayingDatesView(
                movieDateList[index],
                selectedIndex == index ? true : false,
                () => _onTappedSelectd(index));
          },
        ));
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
          shadowColor: THEME_COLOR,
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
