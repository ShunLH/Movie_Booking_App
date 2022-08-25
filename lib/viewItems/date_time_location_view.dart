import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../resources/colors.dart';

class DateTimeLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateTimeIconView("Sat,12Jan 2022", Icons.calendar_month),
          Spacer(),
          DateTimeIconView("3:30 PM", Icons.more_time_sharp),
          Spacer(),
          DateTimeIconView("Junction Square Yangon", Icons.location_on_sharp),
        ],
      ),
    );
  }
}

class DateTimeIconView extends StatelessWidget {
  final String textStr;
  final IconData icon;

  DateTimeIconView(this.textStr, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: THEME_COLOR,
            size: ICON_MEDIUM_SIZE,
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Align(
            alignment: Alignment.center,
            child: Expanded(
              child: Text(
                textStr,
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