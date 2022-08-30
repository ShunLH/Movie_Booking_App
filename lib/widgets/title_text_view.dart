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

class RegularBoldTextView extends StatelessWidget {
  final String _title;
  final Color color;
  RegularBoldTextView(this._title,this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class RegularNormalTextView extends StatelessWidget {
  final String _title;
  final Color color;
  RegularNormalTextView(this._title,this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: this.color,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}