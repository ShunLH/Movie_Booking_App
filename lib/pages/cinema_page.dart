import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/pages/cinema_detail_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewItems/facility_item_view.dart';
import 'package:movie_booking_app/widgets/filter_type_view.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../widgets/cinema_title_view.dart';
import '../widgets/title_text_view.dart';

class CinemaPage extends StatefulWidget {
  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  RangeValues _priceRangeValues = const RangeValues(3500, 15000);
  RangeValues _timeRangeValues = const RangeValues(8, 10);
  List<String> filterTypeList = ["Facilities", "Format"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
                spacing: MARGIN_MEDIUM,
                children: filterTypeList
                    .map((item) => FilterTypeView(item))
                    .toList(),),
            SizedBox(height: MARGIN_MEDIUM),
            PriceRangeSliderView(_priceRangeValues, (values) {
              setState(() {
                this._priceRangeValues = values;
              });
            }),
            SizedBox(height: MARGIN_MEDIUM),
            ShowTimeRangeSliderView(_timeRangeValues, (values) {
              setState(() {
                this._timeRangeValues = values;
              });
            }),
            SizedBox(height: MARGIN_MEDIUM),
            Container(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.white54,
                      ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataRepository.cinemaList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          CinemaView(
                              dataRepository.cinemaList?[index], (cinema) {
                            _navigateToCinemaDetailPage(context,cinema);
                          }),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
  void _navigateToCinemaDetailPage(BuildContext context,CinemaVO cinema) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CinemaDetailPage(cinema)));
  }
}

class CinemaView extends StatelessWidget {
  final CinemaVO? mCinema;
  Function(CinemaVO) onTappedShowDetail;
  CinemaView(this.mCinema, this.onTappedShowDetail);
  @override
  Widget build(BuildContext context) {
    return (mCinema != null)
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CinemaTitleView(mCinema?.name ?? "_", () {
                  onTappedShowDetail(mCinema!);
                }),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: MARGIN_SMALL,
                      alignment: WrapAlignment.start,
                      children: (mCinema?.facilities != null)
                          ? mCinema!.facilities!.map((facility) {
                              return FacilityItemView(facility);
                            }).toList()
                          : [Container()]),
                ),
              ],
            ),
          )
        : Container();
  }
}

class PriceRangeSliderView extends StatelessWidget {
  final RangeValues _priceRangeValues;
  Function(RangeValues) priceRangeValueChanged;
  PriceRangeSliderView(this._priceRangeValues, this.priceRangeValueChanged);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextView("Price Range"),
        SizedBox(height: MARGIN_MEDIUM),
        Row(
          children: [
            RegularNormalTextView("3500Ks", Colors.white54),
            Spacer(),
            RegularNormalTextView("29500Ks", Colors.white54)
          ],
        ),
        RangeSlider(
            values: _priceRangeValues,
            activeColor: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
            inactiveColor: Colors.grey,
            divisions: 10,
            labels: RangeLabels(
              _priceRangeValues.start.round().toString(),
              _priceRangeValues.end.round().toString(),
            ),
            min: 3500,
            max: 29500,
            onChanged: (values) {
              this.priceRangeValueChanged(values);
            }),
      ],
    );
  }
}

class ShowTimeRangeSliderView extends StatelessWidget {
  final RangeValues _timeRangeValues;
  Function(RangeValues) rangeValueChanged;
  ShowTimeRangeSliderView(this._timeRangeValues, this.rangeValueChanged);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextView("Show Times"),
        SizedBox(height: MARGIN_MEDIUM),
        Row(
          children: [
            RegularNormalTextView("8am", Colors.white54),
            Spacer(),
            RegularNormalTextView("12pm", Colors.white54),
          ],
        ),
        RangeSlider(
            values: _timeRangeValues,
            activeColor: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
            divisions: 16,
            inactiveColor: Colors.grey,
            labels: RangeLabels(
              _timeRangeValues.start.round().toString(),
              _timeRangeValues.end.round().toString(),
            ),
            min: 8,
            max: 16,
            onChanged: (values) {
              rangeValueChanged(values);
            }),
      ],
    );
  }
}
