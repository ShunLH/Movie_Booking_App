import 'package:flutter/material.dart';
import 'package:movie_booking_app/assets.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/viewItems/title_text_view.dart';

import '../resources/dimens.dart';
import '../viewItems/cast_view.dart';
import 'movie_time_page.dart';

class MovieDetailsPage extends StatelessWidget {
  final List<String> genreList = ["Action", "Adventure", "Romance","Comedy"];
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
                    genreList,
                    () => Navigator.pop(context),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.only(
                            left: MARGIN_MEDIUM,
                            right: MARGIN_MEDIUM,
                            top: MARGIN_LARGE,
                            bottom: MARGIN_LARGE,
                          ),
                          child: AboutFlimSectionView(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM,
                          ),
                          child: StoryLineSection(),
                        ),
                        SizedBox(
                          height: MARGIN_MEDIUM,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM,
                          ),
                          child: CastSectionView(),
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
              padding: const EdgeInsets.only(
                bottom: MARGIN_LARGE,
              ),
              child: Container(
                width: BOOKING_BTN_WIDTH,
                height: BOOKING_BTN_HEIGHT,
                color: THEME_COLOR,
                child: TextButton(
                    child: Text(
                      "Booking",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => _navigateToMovieTimePage(context)),
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
          builder: (context) => MovieTimePage(),
        ));
  }
}

class CastSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextView(CAST_TITLE),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          HorizontalCastListView(),
        ],
      ),
    );
  }
}

class HorizontalCastListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: CASTS_LIST_HEIGHT,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return CastView(cast_img);
          },
        ));
  }
}

class AboutFlimSectionView extends StatelessWidget {
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
            "Aug 8th,2022",
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          AboutFlimInfoView(
            "Duration",
            "2hr 30min",
          ),
        ],
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextView(STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        StoryLineView(),
      ],
    );
  }
}

class StoryLineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald's growing legion of followers.",
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}

class MovieNameAndGenreView extends StatelessWidget {
  final List<String> genreList;

  MovieNameAndGenreView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "West World",
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: MARGIN_LARGE,
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
          spacing: MARGIN_SMALL,
          alignment: WrapAlignment.start,
          children: genreList.map((genre) => GenreChipView(genre)).toList(),

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
      backgroundColor: THEME_COLOR,
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
  final List<String> genreList;

  final Function onTapBack;
  MovieDetailSliverAppBarView(this.genreList, this.onTapBack);
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
                    child: MovieDetailAppBarImageVIew(),
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
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaejpX80-gQhdc2S8zvpJaxWUGZMHOO7nsNsV1tm0IMj0gmCy5xaiLN5qYR01C8HrT54U&usqp=CAU",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: GENERE_CHIP_VIEW_HEIGHT,
                child: MovieNameAndGenreView(genreList),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
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
                    Text("38876 VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  "9,76",
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
          "The Secrets of Dumbledore",
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
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: THEME_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Text(
          "2016",
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
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://cms.dmpcdn.com/moviearticle/2022/04/13/56fb4fc0-bb49-11ec-8f2e-f393db1d7b77_webp_original.jpg",
      fit: BoxFit.cover,
    );
  }
}
