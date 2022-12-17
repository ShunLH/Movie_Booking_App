import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/colors.dart';
import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../resources/dimens.dart';
import '../widgets/gradient_view.dart';

class MovieView extends StatelessWidget {
  // final String _item;
  final bool isCommingSoon;
  final Function(int) onTapMovie;
  final MovieVO? mMovie;

  MovieView(this.mMovie,this.isCommingSoon,this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
              Radius.circular(MARGIN_CARD_MEDIUM_1)
          )
      ),
      margin: EdgeInsets.only(right: MARGIN_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MOVIE_LIST_ITEM_HEIGHT,
            child: GestureDetector(
              onTap: () {
                onTapMovie(mMovie?.id ?? 0);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(MARGIN_SMALL),topRight: Radius.circular(MARGIN_SMALL)),
                      child: Image.network(
                        "$IMAGE_BASE_URL${mMovie?.posterPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(child: GradientView([Colors.transparent,Colors.black.withOpacity(0.5)],0.0),),
                  Padding(
                    padding: const EdgeInsets.all(MARGIN_XSMALL),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Visibility(
                        visible: this.isCommingSoon,
                        child: CommingDateView(mMovie?.releaseDate ?? ""),),
                    )
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Container(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${mMovie?.title}",
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Row(
                  children: [
                    Container(
                      width: IMDB_ICON_WIDTH,
                      height: IMDB_ICON_HEIGHT,
                      child: Image.asset(
                        "assets/images/imdb_icon.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "9.0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: Row(
              children: [
                Text(
                  "U/A",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: MARGIN_XSMALL,
                ),
                Icon(
                  Icons.circle,
                  size: MARGIN_SMALL,
                  color: Colors.white,
                ),
                SizedBox(
                  width: MARGIN_XSMALL,
                ),
                Text(
                  "2D,3D",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommingDateView extends StatelessWidget {
  final String releaseDate;
  CommingDateView(this.releaseDate);

  String _convertReleaseDateText(commingDate) {
    DateTime comming = DateTime.parse(commingDate);
    String day = DateFormat.d().format(comming);
    String month = DateFormat.LLL().format(comming);
    return "${day}th\n${month.toUpperCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: COMMING_SOON_MOVIE_DATE_VIEW_SIZE,
      height: COMMING_SOON_MOVIE_DATE_VIEW_SIZE,
      decoration: BoxDecoration(
        color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_XSMALL)),
      ),
      child: Center(
        child: Text(
          "${_convertReleaseDateText(releaseDate)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
