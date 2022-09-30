import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class SepartorLineView extends StatelessWidget {
  final Color lineColor;
  SepartorLineView(@required this.lineColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lineColor,
      height: MARGIN_LINE_1,
    );
  }
}

