import 'package:flutter/material.dart';
import 'package:movie_booking_app/assets.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/pages/confirm_success_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/viewItems/date_time_location_view.dart';
import 'package:movie_booking_app/widgets/separator_line_view.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../data/vos/movie_vo.dart';
import '../data/vos/ticket_vo.dart';
import '../widgets/corner_separator_view.dart';

class TicketConfirmationPage extends StatelessWidget {
  final TicketVO? mTicketVO;
  final MovieVO? mMovieVO;

  TicketConfirmationPage(this.mMovieVO,this.mTicketVO);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TitleTextView(TICKET_CONFIRMATION),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          TicketView(mMovieVO,mTicketVO),
          SizedBox(height: MARGIN_XXLARGE),
          QRAndPinView(mTicketVO?.qrCode),
          SizedBox(height: MARGIN_XXLARGE),
          DoneButtonView(() => _onTappedDoneButton(context))
        ]),
      ),
    );
  }

  void _onTappedDoneButton(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => ConfirmSuccessPage()));
  }
}

class TicketView extends StatelessWidget {
  final TicketVO? mTicketVO;
  final MovieVO? mMovieVO;

  TicketView(this.mMovieVO,this.mTicketVO);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [PRIMARY_COLOR,Colors.white12])),
      child: Column(
        children: [
          TicketMovieInfoView(mMovieVO,mTicketVO),
          RoundedCornerSeparatorView(16),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: DateTimeLocationView(bookingDate: (mTicketVO?.bookingDate ?? ""),movieStartTime: (mTicketVO?.timeslot?.startTime ?? ""),cinemaId:(mTicketVO?.cinema_id ?? 0) ,),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedCornerSeparatorView extends StatelessWidget {
  final double cornerRadius;
  RoundedCornerSeparatorView(this.cornerRadius);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: cornerRadius * 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: cornerRadius,
                height: cornerRadius * 2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(cornerRadius),
                      bottomRight: Radius.circular(cornerRadius)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width - cornerRadius * 4,
                child: Align(alignment: Alignment.center,child: SepartorLineView(GRAY_TEXT_COLOR)),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: cornerRadius,
                height: cornerRadius * 2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cornerRadius),
                      bottomLeft: Radius.circular(cornerRadius)),
                ),
              ),
            ),
          ],
        ));
  }
}

class TicketMovieInfoView extends StatelessWidget {
  final TicketVO? mTicketVO;
  final MovieVO? mMovieVO;
  TicketMovieInfoView(this.mMovieVO,this.mTicketVO);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MARGIN_MEDIUM, horizontal: MARGIN_MEDIUM),
        child: Row(
          children: [
            MovieImageView(mMovieVO?.posterPath ?? ""),
            SizedBox(width: MARGIN_SMALL),
            TicketDetailInfoView(mMovieVO,mTicketVO),
          ],
        ),
      ),
    );
  }
}

class MovieImageView extends StatelessWidget {
  final String movieImgURl;
  MovieImageView(this.movieImgURl);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
        child: Image.network(
          "${IMAGE_BASE_URL}${movieImgURl}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class QRAndPinView extends StatelessWidget {
  final String? qrImgURL;
  QRAndPinView(this.qrImgURL);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      child: (qrImgURL != "" && qrImgURL != null) ? Image.network(
        "${PADC_BASE_URL}/${qrImgURL}",fit: BoxFit.cover,
      ) : Image.asset(
        "assets/images/qr_and_pin.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class TicketDetailInfoView extends StatelessWidget {
  final TicketVO? mTicketVO;
  final MovieVO? mMovie;

  TicketDetailInfoView(this.mMovie,this.mTicketVO);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(MARGIN_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${mMovie?.title}",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_1),
          Text(getCinemaNameById(mTicketVO?.cinema_id ?? 0),
            style: TextStyle(
              color: THEME_COLOR,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_1),
          Text(
            "M-Ticket(${mTicketVO?.totalSeat ?? 1})",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_CARD_SMALL,
            ),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_1),
          Row(
            children: [
              Text(
                "${mTicketVO?.seat}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: MARGIN_XSMALL),
              Text(
                "Scrren(2)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_CARD_SMALL,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DoneButtonView extends StatelessWidget {
  Function onTappedDone;

  DoneButtonView(this.onTappedDone);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DONE_BUTTON_WIDTH,
      height: DONE_BTN_HEIGHT,
      color: THEME_COLOR,
      child: TextButton(
        onPressed: () {
          this.onTappedDone();
        },
        child: Text(
          "Done",
          style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
