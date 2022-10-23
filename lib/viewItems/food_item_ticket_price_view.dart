import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../data/vos/snack_vo.dart';
import '../resources/dimens.dart';

class FoodItemTicketPriceView extends StatelessWidget {
  final SnackVO? mSnack;
  Function(int) onTappedDelete;
  // final String itemName;
  // final String price;
  FoodItemTicketPriceView(this.mSnack,this.onTappedDelete);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Image.asset(
      //   imgURL,
      //   width: ICON_MEDIUM_SIZE,
      //   height: ICON_MEDIUM_SIZE,
      // ),
      GestureDetector(
        onTap: () => this.onTappedDelete(mSnack?.id ?? 0),
        child: Icon(
          Icons.delete_forever,
          color: THEME_COLOR,
          size: ICON_MEDIUM_SIZE,
        ),
      ),
      SizedBox(
        width: MARGIN_SMALL,
      ),
      Text(
        "${mSnack?.name}",
        style: TextStyle(
            color: Colors.white60,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.bold),
      ),
      Spacer(),
      Text(
        "${(mSnack?.price ?? 0) * (mSnack?.quantity ?? 0)}Ks",
        style: TextStyle(
            color: Colors.white60,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
