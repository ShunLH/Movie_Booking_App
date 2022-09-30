import 'package:flutter/material.dart';
import 'package:movie_booking_app/network/api_constants.dart';
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
        padding: const EdgeInsets.all(MARGIN_XSMALL), // Border radius
        child: ClipOval(
          child:(imgURL != "") ? Image.network(
            "${IMAGE_BASE_URL}${imgURL}",
            width: CAST_IMAGE_SIZE * 2,
            height: CAST_IMAGE_SIZE * 2,
            fit: BoxFit.cover,
          ): Center(child: Icon(Icons.image_outlined,color: Colors.white,size:MARGIN_LARGE,)) ,
        ),
      ),
    );
  }
}


