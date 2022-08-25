import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class TitleTextView extends StatelessWidget {
  final String _title;
  TitleTextView(this._title);
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR_2X,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
