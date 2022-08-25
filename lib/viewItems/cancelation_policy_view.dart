import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewItems/title_text_view.dart';

class CancelationPolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.all(
            Radius.circular(MARGIN_SMALL),
          ),
          border: Border.all(
            color: THEME_COLOR,
          )),
      child: Column(
        children: [
          TitleTextView("Ticket Cancelation Policy"),
          SizedBox(height: MARGIN_SMALL),
          Row(
            children: [
              Image.asset(
                "assets/images/fnb_icon.png",
                width: ICON_SMALL_SIZE,
                height: ICON_SMALL_SIZE,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
