import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../resources/dimens.dart';


class DesignButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  Function onTappedButton;
  DesignButtonView(this.title,this.backgroundColor,this.onTappedButton);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTappedButton(),
      child: Container(
        width: BOOKING_BTN_WIDTH,
        height: BOOKING_BTN_HEIGHT,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))
        ),
        child:Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(title,style: TextStyle(
                  color: Colors.black,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: CIRCLE_CORNER_SMALL,
                height: CIRCLE_CORNER_SMALL*2,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(CIRCLE_CORNER_SMALL),
                      bottomRight: Radius.circular(CIRCLE_CORNER_SMALL)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: CIRCLE_CORNER_SMALL,
                height: CIRCLE_CORNER_SMALL*2,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CIRCLE_CORNER_SMALL),
                      bottomLeft: Radius.circular(CIRCLE_CORNER_SMALL)),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
