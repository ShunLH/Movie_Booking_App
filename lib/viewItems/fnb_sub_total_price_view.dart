
import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class FnBBottomTotalPriceButtonView extends StatelessWidget {
  final int totalPrice;
  FnBBottomTotalPriceButtonView(this.totalPrice);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: THEME_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(MARGIN_CARD_MEDIUM_1),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM),
            child: BottomExpandableIconView(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM),
            child: TotalPriceView(this.totalPrice),
          )
        ],
      ),
    );
  }
}

class BottomExpandableIconView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_note_outlined,
          color: Colors.black,
        ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Icon(
          Icons.arrow_drop_down_rounded,
          color: Colors.black,
          size: MARGIN_LARGE,
        ),
      ],
    );
  }
}

class TotalPriceView extends StatelessWidget {
  final int totalPrice;
  TotalPriceView(this.totalPrice);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${totalPrice}Ks",
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: MARGIN_LARGE,
        ),
      ],
    );
  }
}