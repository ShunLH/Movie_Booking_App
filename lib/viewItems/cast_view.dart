import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../assets.dart';

class CastView extends StatelessWidget {
  final String imgURL;
  CastView(this.imgURL);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: CAST_IMAGE_SIZE,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(MARGIN_SMALL), // Border radius
        child: ClipOval(
          child: Image.network(
            imgURL,
            width: CAST_IMAGE_SIZE * 2,
            height: CAST_IMAGE_SIZE * 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
