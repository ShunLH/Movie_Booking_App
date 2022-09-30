import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class FacilityItemView extends StatelessWidget {
  final FacilityVO mFacility;
  final Color textColor;
  final Color iconColor;
  FacilityItemView(this.mFacility,{this.textColor = Colors.white70,this.iconColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      width: MediaQuery.of(context).size.width / 3 - 5,
      child: Row(
        children: [
          Image.network("${mFacility.img}",
              color: iconColor,
              width: ICON_MEDIUM_SIZE,
              height: ICON_MEDIUM_SIZE),
          SizedBox(width: MARGIN_XSMALL),
          Expanded(
            child: Text(
              "${mFacility.title}",
              style: TextStyle(
                color: textColor,
                fontSize: TEXT_REGULAR,
              ),
            ),
          ),
        ],
      ),
    );
  }
}