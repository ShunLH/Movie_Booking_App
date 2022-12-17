import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../resources/strings.dart';

class FoodItemView extends StatelessWidget {
  final SnackVO? mSnack;

  Function(SnackVO) onTappedAddButton;

  FoodItemView(this.mSnack,this.onTappedAddButton);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_MEDIUM)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white10, STATUS_SECTION_COLOR]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            height: SNACK_IMAGE_HEIGHT,
            width: (MediaQuery.of(context).size.width / 2) - 36,
            child: FnBImageView("${mSnack?.image}"),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 36,
            child: Text(
              "${mSnack?.name}",
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
            width: (MediaQuery.of(context).size.width / 2) - 36,
            child: Text(
              "${mSnack?.price}",
              style: TextStyle(
                color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
                fontSize: TEXT_CARD_SMALL,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          TextButton(
            onPressed: () => this.onTappedAddButton(mSnack!),
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 36,
              height: ADD_BUTTON_HEIGHT,
              decoration: BoxDecoration(
                color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
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
