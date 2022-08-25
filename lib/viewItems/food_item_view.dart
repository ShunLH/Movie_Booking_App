import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../resources/strings.dart';

class FoodItemView extends StatelessWidget {
  final String item;
  final String itemImage;
  final String itemPrice;

  Function onTappedAddButton;

  FoodItemView(
      this.item, this.itemImage, this.itemPrice, this.onTappedAddButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: STATUS_SECTION_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            height: 130,
            width: (MediaQuery.of(context).size.width/2) - 36,
            child: FnBImageView(itemImage),
          ),
          Container(
            width: (MediaQuery.of(context).size.width/2) - 36,
            child: Text(
              this.item,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_CARD_SMALL,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Container(
            width: (MediaQuery.of(context).size.width/2) - 36,
            child: Text(
              itemPrice,
              style: TextStyle(
                color: THEME_COLOR,
                fontSize: TEXT_CARD_SMALL,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          TextButton(
            onPressed: () => this.onTappedAddButton(),
            child: Container(
              width: (MediaQuery.of(context).size.width/2) - 36,
              height: ADD_BUTTON_HEIGHT,
              decoration: BoxDecoration(
                color: THEME_COLOR,
                borderRadius: BorderRadius.all(
                  Radius.circular(MARGIN_XSMALL),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ADD_BTN_TITLE,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FnBImageView extends StatelessWidget {
  final String itemImage;

  FnBImageView(this.itemImage);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      itemImage,
      fit: BoxFit.cover,
    );
  }
}
