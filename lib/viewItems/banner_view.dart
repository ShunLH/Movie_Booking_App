import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/placeholder_image_view.dart';

class BannerView extends StatelessWidget {
final BannerVO? mBanner;
BannerView(this.mBanner);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
        child: BannerImageView(mBanner?.url),
      ),
      // child: Container(
      //   color: Colors.red,
      // ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String? bannerImage;

  BannerImageView(this.bannerImage);

  @override
  Widget build(BuildContext context) {
    return (bannerImage != null || bannerImage != "") ? Image.network(
      "${this.bannerImage}",
      fit: BoxFit.fitHeight,
    ) : PlaceholderImageView(100);
  }
}


