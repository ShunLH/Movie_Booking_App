import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/viewItems/food_item_ticket_price_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewItems/app_bar_back_button_view.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 600,
              margin: EdgeInsets.all(MARGIN_MEDIUM),
              decoration: BoxDecoration(
                color: CHECKOUT_SCREEN_TICKET_BG_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(MARGIN_MEDIUM)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                child: Column(
                  children: [
                    MovieTitleView(),
                    SizedBox(height: MARGIN_SMALL),
                    CinemaTitleView(),
                    SizedBox(height: MARGIN_SMALL),
                    DateTimeLocationView(),
                    SizedBox(height: MARGIN_SMALL),
                    TicketPriceView(),
                    SizedBox(height: MARGIN_MEDIUM),
                    SeparatorView(),
                    SizedBox(height: MARGIN_MEDIUM),
                    FoodAndBeveragePriceView(),
                    SizedBox(height: MARGIN_MEDIUM),
                    SeparatorView(),
                    SizedBox(height: MARGIN_MEDIUM),
                    ConvenienceFeeView(),
                    SizedBox(height: MARGIN_MEDIUM_2),
                    SeparatorView(),
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
      ),
    );
  }

  void _onTappedContinue(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TicketConfirmationPage()),);
  }
}

class TotalPriceView extends StatelessWidget{

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
          CancelationPolicyButtonView()
        ],
      ),
    );
  }
}

class CancelationPolicyButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
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

class SeparatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Colors.white24,
    );
  }
}

class ContinueButtonView extends StatelessWidget {
  Function onTappedContinue;

  ContinueButtonView(this.onTappedContinue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      color: THEME_COLOR,
      child: TextButton(
        onPressed: () {
          this.onTappedContinue();
        },
        child: Text(
          "Continue",
          style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
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
