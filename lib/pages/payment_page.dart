import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';
import 'package:movie_booking_app/viewItems/payment_type_view.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  MovieModel mMovieModel = MovieModelImpl();
  DataRepository dataRepository = DataRepository();

  List<PaymentTypeVO>? paymentTypes;

  @override
  void initState() {
    super.initState();
    mMovieModel.getPaymentTypes(dataRepository.getAuthorizationToken())?.then((paymentTypesList) {
      setState(() {
        this.paymentTypes = paymentTypesList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TitleTextView("Payment"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NameTextFieldView(),
                        SizedBox(height: MARGIN_MEDIUM_2),
                        ApplyPromoCodeView(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RequiredIconView(),
                  ),
                ],
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM_2),
            Text(
              CHOOSE_PAYMENT_TYPE,
              style: TextStyle(
                color: THEME_COLOR,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (BuildContext context,int index){
            //       return ListTile(
            //           leading: const Icon(Icons.list),
            //           trailing: const Text(
            //             "GFG",
            //             style: TextStyle(color: Colors.green, fontSize: 15),
            //           ),
            //           title: Text("List item $index"));
            //
            //     }),
            SizedBox(height: MARGIN_MEDIUM),
            Container(
              child: (paymentTypes != null) ? Column(
                  children: paymentTypes!
                      .map((item) => PaymentTypeView(item,() => this._navigateToTicketConfirmation(context)))
                      .toList()) : Container(),
            ),
          ],
        ),
      ),

    );
  }

  void _navigateToTicketConfirmation(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => TicketConfirmationPage(),
    ));
  }
}

class RequiredIconView extends StatelessWidget {
  const RequiredIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "*",
      style: TextStyle(
        color: Colors.red,
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ApplyPromoCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: THEME_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: Row(
            children: [
              ImageIconView(
                  "percent_promotion.png", ICON_SMALL_SIZE, Colors.black),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "Unlock offer or Apply Promocode",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}

class NameTextFieldView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        showCursor: true,
        autofocus: true,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: THEME_COLOR, width: 1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: THEME_COLOR),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: THEME_COLOR),
          ),
          labelText: "Your Name",
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: "Enter your name",
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w600,
          ),
          labelStyle: TextStyle(
            color: THEME_COLOR,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
