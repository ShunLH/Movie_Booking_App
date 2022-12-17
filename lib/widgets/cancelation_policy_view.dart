import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../resources/strings.dart';

class CancelationPolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 380,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
          border: Border.all(color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR])),
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          TitleTextView(TICKET_CANCELATION_POLICY),
          SizedBox(height: MARGIN_SMALL),
          PolicyTitleAndIconView("fnb_icon.png", PERCENT_REFUND_ON_FANDB),
          SizedBox(height: MARGIN_MEDIUM),
          PolicyTitleAndIconView("fnb_icon.png", PERCENT_REFUND_ON_TICKETS),
          SizedBox(height: MARGIN_MEDIUM),
          Padding(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: RulesDetailsTextView(
                REFUND_TICKET_POLICY_DETAIL, Colors.white54),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          RulesDetailsTextView(CANCELLATION_RULES, Colors.white),
          SizedBox(height: MARGIN_MEDIUM),
          CloseButtonView(() => this._dismissDialog(context))
        ],
      ),
    );
  }

  void _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}

class CloseButtonView extends StatelessWidget {
  Function onTappedClose;

  CloseButtonView(this.onTappedClose);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: DONE_BTN_HEIGHT,
      decoration: BoxDecoration(
          color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
      child: TextButton(
        onPressed: () {
          this.onTappedClose();
        },
        child: Text(
          "Close",
          style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class RulesDetailsTextView extends StatelessWidget {
  final String textString;
  final Color textColor;

  RulesDetailsTextView(this.textString, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Text(
          textString,
          style: TextStyle(
              color: textColor,
              fontSize: TEXT_CARD_SMALL,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PolicyTitleAndIconView extends StatelessWidget {
  final String iconName;
  final String title;
  PolicyTitleAndIconView(this.iconName, this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIconView(iconName, ICON_SMALL_SIZE, Colors.white),
        SizedBox(width: MARGIN_SMALL),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR),
          ),
        ),
      ],
    );
  }
}
