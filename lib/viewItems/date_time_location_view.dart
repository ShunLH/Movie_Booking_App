import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../data/vos/ticket_vo.dart';
import '../resources/colors.dart';

class DateTimeLocationView extends StatelessWidget {
  final String bookingDate;
  final String movieStartTime;
  final int cinemaId;
  DateTimeLocationView({required this.bookingDate,required this.movieStartTime,required this.cinemaId});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        children: [
          DateTimeIconView(bookingDate, Icons.calendar_month),
          Spacer(),
          DateTimeIconView(movieStartTime, Icons.more_time_sharp),
          Spacer(),
          DateTimeIconView(getCinemaAddressById(cinemaId), Icons.location_on_sharp),
        ],
      ),
    );
  }
}
String getCinemaNameById(int cinemaId){
  var cinema = dataRepository.cinemaList?.where((cinema) => cinema.id == cinemaId).first;
  return cinema?.name ?? "";
}
String getCinemaAddressById(int cinemaId){
  var cinema = dataRepository.cinemaList?.where((cinema) => cinema.id == cinemaId).first;
  return cinema?.address ?? "";
}
class DateTimeIconView extends StatelessWidget {
  final String textStr;
  final IconData icon;

  DateTimeIconView(this.textStr, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: THEME_COLOR,
            size: MARGIN_LARGE,
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Align(
            alignment: Alignment.center,
            child: Expanded(
              child: Text(
                textStr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_CARD_SMALL,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}