import 'package:flutter/material.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';

class CinemaTitleView extends StatelessWidget {
  Function onTapSeeDetail;
  final String title;
  CinemaTitleView(this.title, this.onTapSeeDetail);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleTextView(title),
        Spacer(),
        SeeDetailsButtonView(() => this.onTapSeeDetail())
      ],
    );
  }
}

class SeeDetailsButtonView extends StatelessWidget {
  Function onTapSeeDetail;
  SeeDetailsButtonView(this.onTapSeeDetail);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        this.onTapSeeDetail();
      },
      child: Text(
        SEE_DETAILS_TITLE,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: THEME_COLOR,
        ),
      ),
    );
  }
}