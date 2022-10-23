import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/promo_video_player_view.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../data/vos/cinema_vo.dart';
import '../viewItems/facility_item_view.dart';

class CinemaDetailPage extends StatelessWidget {
  final CinemaVO mCinema;
  CinemaDetailPage(this.mCinema);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Text(CINEMA_DETAIL, style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
            child: Icon(Icons.star_border_rounded,
                color: Colors.white, size: MARGIN_XLARGE),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PromoView(mCinema,(movieURL)=> _navigateToPlayerView(context,movieURL)),
          Container(
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextView(mCinema.name ?? ""),
                  SizedBox(height: MARGIN_MEDIUM),
                  CinemaAddressTextView(mCinema),
                  SizedBox(height: MARGIN_XLARGE),
                  CinemaFacilitiesView(mCinema: mCinema),
                  SizedBox(height: MARGIN_LARGE),
                  TitleTextView("Safety"),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: MARGIN_SMALL,
                        alignment: WrapAlignment.start,
                        children: (mCinema?.safety != null)
                            ? mCinema!.safety!.map((safety) {
                                return ChipView(
                                  textStr: "${safety}",
                                );
                              }).toList()
                            : [Container()]),
                  ),
                ],
              )),
        ],
      )),
    );
  }
  void _navigateToPlayerView(BuildContext context,String movieURL){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerView(movieURL)));
  }
}

class CinemaFacilitiesView extends StatelessWidget {
  const CinemaFacilitiesView({
    Key? key,
    required this.mCinema,
  }) : super(key: key);

  final CinemaVO mCinema;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextView(FACILITIES_TITLE ?? ""),
        SizedBox(height: MARGIN_MEDIUM),
        SizedBox(
          width: double.infinity,
          child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: (mCinema?.facilities != null)
                  ? mCinema!.facilities!.map((facility) {
                      return ChipView(
                        textStr: facility.title ?? "",
                        iconURL: facility.img,
                        color: THEME_COLOR,
                        backgroundColor: PRIMARY_COLOR,
                        fontSize: TEXT_CARD_SMALL,
                      );
                      // return FacilityItemView(facility,textColor: THEME_COLOR,iconColor: THEME_COLOR);
                    }).toList()
                  : [Container()]),
        ),
      ],
    );
  }
}

class CinemaAddressTextView extends StatelessWidget {
  final CinemaVO mCinema;
  CinemaAddressTextView(this.mCinema);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            mCinema.address ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Image.asset(
          NAVIGATION_ICON_ASSETS_URL,
          color: THEME_COLOR,
          width: MARGIN_XLARGE,
          height: MARGIN_XLARGE,
        ),
      ],
    );
  }
}

class PromoView extends StatelessWidget {
  final CinemaVO mCinema;
  Function(String) onTappedViewPromoVideo;
  PromoView(this.mCinema, this.onTappedViewPromoVideo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => onTappedViewPromoVideo(mCinema.promoVdoURL ?? ""),
              child: CinemaPromoVideoView(mCinema.promoVdoURL ?? ""),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_fill,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CinemaPromoVideoView extends StatelessWidget {
  final String videoURL;
  CinemaPromoVideoView(this.videoURL);
  @override
  Widget build(BuildContext context) {
    return (videoURL != "")
        ? Image.network(
            "https://businessday.ng/wp-content/uploads/2022/01/cinema2520industry.jpg",
            // "${videoURL}",
            fit: BoxFit.cover,
          )
        : Center(
            child: Icon(
            Icons.image_outlined,
            size: MARGIN_XXLARGE,
            color: Colors.white,
          ));
  }
}

class ChipView extends StatelessWidget {
  final String textStr;
  final String? iconURL;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  ChipView(
      {required this.textStr,
      this.color = PRIMARY_COLOR,
      this.backgroundColor = THEME_COLOR,
      this.fontSize = 10.0,
      this.iconURL = null});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: (iconURL != null)
          ? Image.network(
              iconURL ?? "",
              width: ICON_SMALL_SIZE,
              height: ICON_SMALL_SIZE,
              color: color,
            )
          : null,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
      backgroundColor: backgroundColor,
      label: Text(
        textStr,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
