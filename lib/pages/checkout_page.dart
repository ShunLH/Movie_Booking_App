import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/widgets/cancelation_policy_view.dart';
import 'package:movie_booking_app/viewItems/food_item_ticket_price_view.dart';
import 'package:movie_booking_app/widgets/corner_separator_view.dart';
import 'package:movie_booking_app/widgets/design_button_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/app_bar_back_button_view.dart';
import '../viewItems/date_time_location_view.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Container(
          child: Text(
            "CheckOut",
            style: TextStyle(
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ),
        leading: AppBarBackButtonView(() {
          Navigator.pop(context);
        }),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 560,
                  decoration: BoxDecoration(
                    color: CHECKOUT_SCREEN_TICKET_BG_COLOR,
                    borderRadius:
                        BorderRadius.all(const Radius.circular(MARGIN_MEDIUM)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [Colors.white12,Colors.white38]
                    ),
                  ),

                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MARGIN_MEDIUM),
                            child: Container(
                              child: Column(
                                children: [
                                  MovieTitleView(),
                                  SizedBox(height: MARGIN_SMALL),
                                  CinemaTitleView(),
                                  SizedBox(height: MARGIN_SMALL),
                                  DateTimeLocationView(),
                                  SizedBox(height: MARGIN_SMALL),
                                  TicketPriceView(),
                                  SizedBox(height: MARGIN_SMALL),
                                  SeparatorView(0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Padding(
                        padding: EdgeInsets.all(MARGIN_MEDIUM),
                        child: FoodAndBeveragePriceView(),
                      ),
                    ),
                    CornerSeparator(30, Colors.transparent),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Padding(
                        padding: EdgeInsets.all(MARGIN_MEDIUM),
                        child: Column(
                          children: [
                            ConvenienceFeeView(() {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(""),
                                    backgroundColor: Colors.transparent,
                                    content: CancelationPolicyView(),
                                  );
                                },
                              );
                            }),
                            SizedBox(height: MARGIN_MEDIUM_2),
                            SeparatorView(0),
                            SizedBox(height: MARGIN_MEDIUM_2),
                            TotalPriceView(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MARGIN_LARGE),
                    ContinueButtonView(() => _onTappedContinue(context)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTappedContinue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  // Widget _onTappedCancelationPolicy(BuildContext context) {
  //   return showDialog(context: context, builder: (context) {  return AlertDialog(
  //     title: Text(""),
  //     content: CancelationPolicyView(),
  //   );});
  //
  // }
}

class TotalPriceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "Total",
            style: TextStyle(
              color: THEME_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Text(
            "22500Ks",
            style: TextStyle(
                color: THEME_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ConvenienceFeeView extends StatelessWidget {
  Function onTappedCancelationPolicy;
  ConvenienceFeeView(this.onTappedCancelationPolicy);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Convenience Fee",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: MARGIN_XSMALL,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: ICON_SMALL_SIZE,
              ),
              Spacer(),
              Text(
                "500Ks",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          CancelationPolicyButtonView(() => this.onTappedCancelationPolicy())
        ],
      ),
    );
  }
}

class CancelationPolicyButtonView extends StatelessWidget {
  Function onTappedCancelationPolicy;
  CancelationPolicyButtonView(this.onTappedCancelationPolicy);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTappedCancelationPolicy(),
      child: Container(
          width: 240,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(MARGIN_MEDIUM))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: ICON_MEDIUM_SIZE,
                ),
                SizedBox(width: MARGIN_XSMALL),
                Text(
                  "Ticket cancelation Policy",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class FoodAndBeveragePriceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodAndBeverageTotalPriceTitleView(),
        SizedBox(height: MARGIN_SMALL),
        FoodItemTicketPriceView("CocoaCola", "1000"),
        SizedBox(height: MARGIN_SMALL),
        FoodItemTicketPriceView("Potato Chips", "1000"),
      ],
    );
  }
}

class TicketPriceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "M-Tickets(2)",
          style: TextStyle(
              color: Colors.white24,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Row(
          children: [
            Text(
              "Gold-G8,G7",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "2000Ks",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class ContinueButtonView extends StatelessWidget {
  Function onTappedContinue;

  ContinueButtonView(this.onTappedContinue);

  @override
  Widget build(BuildContext context) {
    return DesignButtonView("Continue", THEME_COLOR, ()=>onTappedContinue());
  }
}

class CinemaTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "JCGV: Junction City",
          style: TextStyle(
            color: THEME_COLOR,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Text(
          "(Screen 2)",
          style: TextStyle(
            color: Colors.white24,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
  }
}

class MovieTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Black Window",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: MARGIN_XSMALL,
        ),
        Text(
          "(3D)(U/A)",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class FoodAndBeverageTotalPriceTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.emoji_food_beverage_rounded,
        color: Colors.white,
        size: ICON_MEDIUM_SIZE,
      ),
      SizedBox(
        width: MARGIN_SMALL,
      ),
      Text(
        "Food and Beverage",
        style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: MARGIN_SMALL,
      ),
      Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
        size: ICON_SMALL_SIZE,
      ),
      Spacer(),
      Text(
        "2000Ks",
        style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
