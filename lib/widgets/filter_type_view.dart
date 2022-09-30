import 'package:flutter/material.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../resources/dimens.dart';

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