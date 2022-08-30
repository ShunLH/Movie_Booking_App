import 'package:flutter/material.dart';

class ImageIconView extends StatelessWidget {
  final String imgName;
  final double iconSize;
  final Color? iconColor;
  ImageIconView(this.imgName,this.iconSize,this.iconColor);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/$imgName",
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  }
}
