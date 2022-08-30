import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class GradientView extends StatelessWidget {
  final List<Color> colorList;
  final double cornerRadius;

  GradientView(this.colorList,this.cornerRadius);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colorList,

        ),
      ),
    );
  }
}