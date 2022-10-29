import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:movie_booking_app/pages/cinema_detail_page.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../data/vos/movie_date_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/dummy.dart';
import '../resources/dimens.dart';
import '../viewItems/facility_item_view.dart';
import '../viewItems/playing_dates_view.dart';
import '../widgets/app_bar_back_button_view.dart';
import '../widgets/cinema_title_view.dart';
import '../widgets/icon_text_view.dart';

class MovieTimePage extends StatefulWidget {
  final MovieVO? mMovie;
  MovieTimePage(this.mMovie);
  @override
  State<MovieTimePage> createState() => _MovieTimePageState();
}

class _MovieTimePageState extends State<MovieTimePage> {
  final List<String> cinemaTypeList = ["2D", "3D", "3D Max", "3D DBox"];
  MovieModel mMovieModel = MovieModelImpl();
  List<MovieDateVO> mDatesList = [];
  List<CinemaDayTimeslotsVO>? mCinemaTimeSlotsList;
  int selectedCinemaDayTimeSlotId = 1;
  String selectedDate = "";

  @override
  void initState() {
    super.initState();
    _generateMovieShowingDatesList();
    String dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _getCinemaAndShowTimeByDate(dateString);
  }

  void _getCinemaAndShowTimeByDate(String dateString) {
    print("dateString ${dateString}");
    // mMovieModel
    //     .getCinemaAndShowTimeByDate(
    //         mMovieModel.getTokenFromDatabase(), dateString)
    //     ?.then((timeSlotsList) {
    //   setState(() {
    //     mCinemaTimeSlotsList = timeSlotsList;
    //   });
    // });

    /// Database
    mMovieModel
        .getCinemaAndShowTimeByDateFromDatabase(
        dateString)
        ?.listen((timeSlotsList) {
      setState(() {
        mCinemaTimeSlotsList = timeSlotsList;
      });
    });
  }

  void _generateMovieShowingDatesList() {
    DateTime today = DateTime.now();
    for (var i = 0; i < 14; i++) {
      DateTime date = today.add(Duration(days: i));
      if (i == 0) {
        mDatesList.add(MovieDateVO(
            "Today",
            DateFormat.LLL().format(date),
            DateFormat.d().format(date),
            DateFormat('yyyy-MM-dd').format(date),
            date));
      } else if (i == 1) {
        mDatesList.add(MovieDateVO(
            "Tomorrow",
            DateFormat.LLL().format(date),
            DateFormat.d().format(date),
            DateFormat('yyyy-MM-dd').format(date),
            date));
      } else {
        mDatesList.add(MovieDateVO(
            DateFormat.E().format(date),
            DateFormat.LLL().format(date),
            DateFormat.d().format(date),
            DateFormat('yyyy-MM-dd').format(date),
            date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Container(
          child: LocationView(dataRepository.location?.name ?? ""),
        ),
        leading: AppBarBackButtonView(() {
          Navigator.pop(context);
        }),
        actions: [
          Container(
            padding: EdgeInsets.all(MARGIN_SMALL),
            child: Icon(Icons.search),
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
                child: HorizontalMoviePlayingDatesListView(this.mDatesList,
                    (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    _getCinemaAndShowTimeByDate(selectedDate);
                  });
                }),
              ),
              SizedBox(height: MARGIN_MEDIUM),
              CinemaTypeSectionView(cinemaTypeList),
              SizedBox(height: MARGIN_MEDIUM),
              AvaliableStatusSectionView(),
              SizedBox(height: MARGIN_MEDIUM),
              Container(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.white54,
                        ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mCinemaTimeSlotsList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return AvaliableCinemaView(mCinemaTimeSlotsList![index]!,
                          (cinema, timeslot) {
                        _navigateToFoodAndBeverageView(context, cinema,
                            mCinemaTimeSlotsList![index], timeslot);
                      },(cinema) {_navigateToCinemaDetail(context,cinema);},);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _navigateToCinemaDetail(BuildContext context, CinemaVO cinema){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CinemaDetailPage(cinema),
        ));
  }

  void _navigateToFoodAndBeverageView(BuildContext context, CinemaVO cinema,
      CinemaDayTimeslotsVO cTimeSlot, timeslot) {
    print("timeslot selected ${cTimeSlot} id ${timeslot.toString()}");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodAndBeveragePage(
              this.widget.mMovie, cinema, cTimeSlot, timeslot, selectedDate),
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
  final CinemaDayTimeslotsVO mCinemaDayTimeSlots;
  Function(CinemaVO, TimeSlotVO) onTappedMovieTime;
  Function(CinemaVO) onTappedCinema;

  AvaliableCinemaView(this.mCinemaDayTimeSlots, this.onTappedMovieTime,this.onTappedCinema);

  @override
  State<AvaliableCinemaView> createState() => _AvaliableCinemaViewState();
}

class _AvaliableCinemaViewState extends State<AvaliableCinemaView> {
  bool isShowDetail = false;
  CinemaVO? mCinema;
  @override
  void initState() {
    super.initState();
    int cinemaId = widget.mCinemaDayTimeSlots.cinemaId ?? 0;
    mCinema = dataRepository.cinemaList
        ?.where((cinema) => cinema.id == cinemaId)
        .first;
  }

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
          GestureDetector(
            onTap: () => this.widget.onTappedCinema(mCinema!),
            child: CinemaTitleView(widget.mCinemaDayTimeSlots.cinema ?? "_", () {
              _onTappedShowDetail();
            }),
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
                direction: Axis.horizontal,
                spacing: MARGIN_XSMALL,
                runSpacing: MARGIN_SMALL,
                alignment: WrapAlignment.start,
                children: (mCinema?.facilities != null)
                    ? mCinema!.facilities!.map((facility) {
                        return FacilityItemView(facility);
                      }).toList()
                    : [Container()]),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Visibility(
            visible: this.isShowDetail ? true : false,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        widget.mCinemaDayTimeSlots.timeslots?.length ?? 0,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                        child: MovieTimeView(
                            widget.mCinemaDayTimeSlots.timeslots![index],
                            (timeSlot) => this
                                .widget
                                .onTappedMovieTime(mCinema!, timeSlot)),
                      );
                    },
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
  final TimeSlotVO movieTimeSlot;
  Function(TimeSlotVO) onTappedMoviewTime;

  MovieTimeView(this.movieTimeSlot, this.onTappedMoviewTime);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTappedMoviewTime(movieTimeSlot),
      child: Container(
        decoration: BoxDecoration(
            color: _getBackgroundColor(this.movieTimeSlot.status ?? 0)
                .withOpacity(0.15),
            border: Border.all(
                color: _getBackgroundColor(this.movieTimeSlot.status ?? 0),
                width: 2.0)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeslotText(movieTimeSlot, this.movieTimeSlot.startTime ?? ""),
              SizedBox(height: MARGIN_XSMALL),
              TimeslotText(movieTimeSlot, "2D"),
              SizedBox(height: MARGIN_XSMALL),
              TimeslotText(movieTimeSlot, "Screen Type"),
              SizedBox(height: MARGIN_XSMALL),
              Visibility(
                visible: this.movieTimeSlot.status != 0 ? true : false,
                child: TimeslotText(movieTimeSlot,
                    _getAvaliableStatus(this.movieTimeSlot.status ?? 0)),
              ),
            ]),
      ),
    );
  }

  Color _getBackgroundColor(int status) {
    Color bgColor = PRIMARY_COLOR;
    CinemaTimeSlotStatusVO? timeSlotStatus = dataRepository
        .cinemaTimeSlotStatusList
        ?.where((timeSlotSatus) => timeSlotSatus.id == status)
        .first;
    if (timeSlotStatus != null) {
      return colorFromHex(timeSlotStatus.color ?? "#111111");
    }
    return bgColor;
  }

  String _getAvaliableStatus(int status) {
    switch (status) {
      case 1:
        return "50 Avaliable";
      case 2:
        return "20 Avaliable";
      case 3:
        return "10 Avaliable";
      default:
        return "Avaliable";
    }
  }
}

class TimeslotText extends StatelessWidget {
  final TimeSlotVO movieTimeSlot;
  final String textString;
  TimeslotText(this.movieTimeSlot, this.textString);

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: TextStyle(
        color: this.movieTimeSlot.status == 0 ? GRAY_TEXT_COLOR : Colors.white,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}

class HorizontalMoviePlayingDatesListView extends StatefulWidget {
  final List<MovieDateVO> mDatesList;
  Function(String) onTappedDate;
  HorizontalMoviePlayingDatesListView(this.mDatesList, this.onTappedDate);
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
          itemCount: widget.mDatesList.length,
          itemBuilder: (BuildContext context, int index) {
            return PlayingDatesView(
                widget.mDatesList[index], selectedIndex == index ? true : false,
                () {
              _onTappedSelectd(index);
              this
                  .widget
                  .onTappedDate(widget.mDatesList[index].dateFormatedString);
            });
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
        SizedBox(width: MARGIN_MEDIUM),
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
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: MARGIN_MEDIUM,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: (dataRepository.cinemaTimeSlotStatusList != null)
              ? dataRepository.cinemaTimeSlotStatusList!.map((timeSlot) {
                  return StatusView("${timeSlot.title}",
                      colorFromHex(timeSlot.color ?? "#111111"));
                }).toList()
              : [Container()],
        ),
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: MARGIN_SMALL),
      width: MediaQuery.of(context).size.width / 3 - 30,
      child: Row(
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
      ),
    );
  }
}
