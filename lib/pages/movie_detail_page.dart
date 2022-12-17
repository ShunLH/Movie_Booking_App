import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/credit_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';
import 'package:movie_booking_app/widgets/gradient_view.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../resources/dimens.dart';
import '../viewItems/cast_view.dart';
import '../widgets/design_button_view.dart';
import '../widgets/wrapped_casts_list_view.dart';
import 'movie_time_page.dart';

class MovieDetailsPage extends StatefulWidget {
  final bool isCommingSoon;
  final int movieId;

  MovieDetailsPage({required this.isCommingSoon, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieModel? mMovieModel = MovieModelImpl();
  MovieVO? mMovie;
  List<CreditVO>? mActorsList;

  @override
  void initState() {
    super.initState();
    print("movie id ===> ${widget.movieId}");
    // mMovieModel?.getMovieDetails(widget.movieId)?.then((movie) {
    //   setState(() {
    //     this.mMovie = movie;
    //   });
    // });

    mMovieModel?.getMovieDetailsFromDatabase(widget.movieId)?.listen((movie) {
      setState(() {
        this.mMovie = movie;
      });
    });

    // mMovieModel?.getCreditsByMovie(widget.movieId)?.then((creditsList) {
    //   setState(() {
    //     this.mActorsList =
    //         creditsList.where((credit) => credit.isActor()).toList();
    //   });
    // });
    mMovieModel?.getCreditsByMovieFromDatabase(widget.movieId)?.listen((creditsList) {
      setState(() {
        this.mActorsList = creditsList.where((credit) => credit.isActor()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: PRIMARY_COLOR,
              child: CustomScrollView(
                slivers: [
                  MovieDetailSliverAppBarView(
                      mMovie, () => Navigator.pop(context)),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.only(
                              left: MARGIN_MEDIUM,
                              right: MARGIN_MEDIUM,
                              top: MARGIN_LARGE,
                              bottom: MARGIN_LARGE),
                          child: AboutFlimSectionView(mMovie),
                        ),
                        Visibility(
                          visible: widget.isCommingSoon,
                          child: CommingSoonView(mMovie),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                          child: StoryLineSection(mMovie),
                        ),
                        SizedBox(height: MARGIN_MEDIUM),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                          child: CastSectionView(mActorsList),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: MARGIN_LARGE),
              child: Visibility(
                visible: !widget.isCommingSoon,
                child: BookingButtonView(
                    () => this._navigateToMovieTimePage(context)),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _navigateToMovieTimePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieTimePage(mMovie),
        ));
  }
}

class CommingSoonView extends StatelessWidget {
  final MovieVO? mMovie;
  CommingSoonView(this.mMovie);

  int _calculateReleaseDay(String releaseDate) {
    DateTime today = DateTime.now();
    DateTime release = DateTime.parse(releaseDate);
    final difference = today.difference(release).inDays;

    print("$release");

    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.only(
          left: MARGIN_MEDIUM, right: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM),
      child: Stack(
        children: [
          Positioned.fill(
              child: Container(
            child: GradientView(
              [
                Colors.white12,
                DARK_GRAY_TEXT_COLOR,
              ],
              MARGIN_MEDIUM,
            ),
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularBoldTextView(
                        (mMovie?.releaseDate != null)
                            ? "Releasing in ${_calculateReleaseDay(mMovie?.releaseDate ?? "")} days"
                            : "Releasing Soon",
                        Colors.white),
                    SizedBox(height: MARGIN_MEDIUM),
                    Wrap(children: [
                      RegularNormalTextView(
                          "Get notify as soon as movie booking opens up in your city!",
                          DARK_GRAY_TEXT_COLOR)
                    ]),
                    SizedBox(height: MARGIN_MEDIUM),
                    NotificationButtonView(
                        () => this._onClickNotification(context))
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CommingSoonIllustrationImageView(),
          )
        ],
      ),
    );
  }

  void _onClickNotification(BuildContext context) {
    print("_onClickNotification");
  }
}

class CommingSoonIllustrationImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Image.asset(
        "assets/images/illustration.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class NotificationButtonView extends StatelessWidget {
  Function onTappedButton;

  NotificationButtonView(this.onTappedButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: DONE_BTN_HEIGHT,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      decoration: BoxDecoration(
          color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL))),
      child: TextButton(
        onPressed: () {
          this.onTappedButton();
        },
        child: Container(
          child: Row(children: [
            Icon(Icons.notifications_active,
                color: Colors.black, size: ICON_MEDIUM_SIZE),
            Spacer(),
            Text(
              "Notifications",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w700),
            ),
          ]),
        ),
      ),
    );
  }
}

class CastSectionView extends StatelessWidget {
  final List<CreditVO>? castsList;
  CastSectionView(this.castsList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextView(CAST_TITLE),
          (ConfigClass.layout == "List") ? HorizontalCastListView(castsList) :
          WrappedCastsListView(castsList),
          // HorizontalCastListView(castsList),
        ],
      ),
    );
  }
}

class HorizontalCastListView extends StatelessWidget {
  final List<CreditVO>? castsList;
  HorizontalCastListView(this.castsList);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: CASTS_LIST_HEIGHT,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: castsList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Column(
                children: [
                  CastView(castsList?[index].profilePath ?? ""),
                  SizedBox(height: MARGIN_SMALL),
                  Expanded(
                    child: Text(
                      castsList?[index].originalName ?? "",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontSize: TEXT_REGULAR),
                    ),
                  )
                ],
              ),
            );
          },
        )
        // child: GridView.builder(
        //     shrinkWrap: true,
        //     physics: NeverScrollableScrollPhysics(),
        //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //         maxCrossAxisExtent: MediaQuery.of(context).size.width/4,
        //         childAspectRatio: 0.7,
        //         crossAxisSpacing: 8,
        //         mainAxisSpacing: 8),
        //     itemCount: castsList?.length ?? 0,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Column(
        //         children: [
        //           CastView(castsList?[index].profilePath ?? ""),
        //           SizedBox(height: MARGIN_SMALL),
        //           Expanded(
        //             child: Text(
        //               castsList?[index].originalName ?? "",
        //               textAlign: TextAlign.center,
        //               style:
        //                   TextStyle(color: Colors.white, fontSize: TEXT_REGULAR),
        //             ),
        //           )
        //         ],
        //       );
        //     }),
        );
  }
}

class AboutFlimSectionView extends StatelessWidget {
  final MovieVO? mMovie;

  AboutFlimSectionView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AboutFlimInfoView(
            "Censor Rating",
            "U/A",
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          AboutFlimInfoView(
            "Release Date",
            "${mMovie?.releaseDate}",
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          AboutFlimInfoView(
            "Duration",
            _MovieDuartion(mMovie?.runtime ?? 0.0),
          ),
        ],
      ),
    );
  }

  String _MovieDuartion(runtime) {
    int hr = (runtime / 60).toInt();
    var min = (runtime % 60).toInt();
    return "$hr hr" + "${(min > 0) ? "$min min" : ""}";
  }
}

class AboutFlimInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFlimInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.3) - 8,
      decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(
            Radius.circular(MARGIN_CARD_MEDIUM_2),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryLineSection extends StatelessWidget {
  final MovieVO? mMovie;
  StoryLineSection(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextView(STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        StoryLineView(mMovie?.overview ?? ""),
      ],
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String movieDesc;
  StoryLineView(this.movieDesc);
  @override
  Widget build(BuildContext context) {
    return Text(
      "$movieDesc",
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}

class MovieNameAndGenreView extends StatelessWidget {
  final MovieVO? mMovie;

  MovieNameAndGenreView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: 140,
                child: Text(
                  "${mMovie?.originalTitle ?? ""}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MARGIN_LARGE,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: IMDB_ICON_WIDTH,
                  height: IMDB_ICON_HEIGHT,
                  child: Image.asset(
                    IMDG_IMAGE_ASSETS_URL,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  "${(mMovie?.voteAverage ?? 0).toStringAsPrecision(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          "2D",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: MARGIN_XSMALL,
          alignment: WrapAlignment.start,
          children: (mMovie?.genres != null)
              ? mMovie!.genres!
                  .map((genre) => GenreChipView(genre.name ?? ""))
                  .toList()
              : [Container()],
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
      label: Text(
        genreText,
        style: TextStyle(
          color: PRIMARY_COLOR,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MovieDetailSliverAppBarView extends StatelessWidget {
  final MovieVO? mMovie;

  final Function onTapBack;
  MovieDetailSliverAppBarView(this.mMovie, this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAIL_HEADER_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MOVIE_DETAIL_IMAGE_HEIGHT,
                    child:
                        MovieDetailAppBarImageVIew(mMovie?.backDropPath ?? ""),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(() => onTapBack()),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: ShareButtonView(),
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM,
                  bottom: 0,
                ),
                // child: MovieDetailAppBarInfoView(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: (mMovie?.posterPath != null)
                      ? Image.network(
                          "${IMAGE_BASE_URL}${mMovie?.posterPath}",
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                          Icons.image_outlined,
                          size: MARGIN_XXLARGE,
                          color: Colors.white,
                        )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: GENERE_CHIP_VIEW_HEIGHT,
                child: MovieNameAndGenreView(mMovie),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {
  final MovieVO? mMovie;
  MovieDetailAppBarInfoView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(mMovie?.releaseDate ?? ""),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text("${mMovie?.voteCount ?? 0} VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  "${(mMovie?.popularity ?? 0).round()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "${mMovie?.originalTitle ?? ""}",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String mReleaseDate;

  MovieDetailsYearView(this.mReleaseDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Text(
          "${mReleaseDate.substring(mReleaseDate.length - 4)}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ShareButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.share,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  BackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailAppBarImageVIew extends StatelessWidget {
  final String movieImageURl;
  MovieDetailAppBarImageVIew(this.movieImageURl);
  @override
  Widget build(BuildContext context) {
    return (movieImageURl != "")
        ? Image.network(
            "${IMAGE_BASE_URL}${movieImageURl}",
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

class BookingButtonView extends StatelessWidget {
  Function onTappedBooking;
  BookingButtonView(this.onTappedBooking);
  @override
  Widget build(BuildContext context) {
    return DesignButtonView(
        "Booking", THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR], () => this.onTappedBooking());
  }
}
