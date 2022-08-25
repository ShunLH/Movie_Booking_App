import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_SMALL),
      child: BannerImageView(),
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxwDwzu3trKoh0EtVAHLRvLjmYXVQTDLB8ORj8InCzKVaKcq7HzSl6Ak6noizAvYtImng&usqp=CAU",
      fit: BoxFit.cover,
    );
  }
}
