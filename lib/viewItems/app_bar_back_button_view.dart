import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class AppBarBackButtonView extends StatelessWidget {
  final Function onTapBack;
  AppBarBackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        padding: EdgeInsets.all(MARGIN_SMALL),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}