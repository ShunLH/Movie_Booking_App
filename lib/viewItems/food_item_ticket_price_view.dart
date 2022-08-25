import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../resources/dimens.dart';

class FoodItemTicketPriceView extends StatelessWidget {
  final String itemName;
  final String price;
  FoodItemTicketPriceView(this.itemName, this.price);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Image.asset(
      //   imgURL,
      //   width: ICON_MEDIUM_SIZE,
      //   height: ICON_MEDIUM_SIZE,
      // ),
      Icon(
        Icons.delete_forever,
        color: THEME_COLOR,
        size: ICON_MEDIUM_SIZE,
      ),
      SizedBox(
        width: MARGIN_SMALL,
      ),
      Text(
        this.itemName,
        style: TextStyle(
            color: Colors.white60,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.bold),
      ),
      Spacer(),
      Text(
        this.price,
        style: TextStyle(
            color: Colors.white60,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
