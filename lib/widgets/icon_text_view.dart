import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class IconTextView extends StatelessWidget {
  final String title;
  final String icon;
  IconTextView(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(AssetImage("assets/images/$icon"),color: Colors.white,size: ICON_MEDIUM_SIZE),
        // Icon(
        //   icon,
        //   size: ICON_MEDIUM_SIZE,
        //   color: Colors.white70,
        // ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
  }
}