import 'package:flutter/material.dart';
import 'package:movie_booking_app/config/environment_config.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/widgets/cancelation_policy_view.dart';
import 'package:movie_booking_app/viewItems/food_item_ticket_price_view.dart';
import 'package:movie_booking_app/widgets/corner_separator_view.dart';
import 'package:movie_booking_app/widgets/design_button_view.dart';
import '../config/config_values.dart';
import '../data/vos/c_snack_vo.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/date_vo.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/snack_vo.dart';
import '../data/vos/timeslot_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/app_bar_back_button_view.dart';
import '../viewItems/date_time_location_view.dart';

class CheckOutPage extends StatefulWidget {
  final MovieVO? mMovie;
  final CinemaVO? mCinema;
  final List<SnackVO>? mSnackList;
  final CinemaDayTimeslotsVO? mCinemaTimeSlot;
  final TimeSlotVO? cinemaTimeSlot;
  final String? bookingDate;

  CheckOutPage({required this.mMovie, required this.mCinema,required this.mSnackList,required this.mCinemaTimeSlot,required this.cinemaTimeSlot,required this.bookingDate});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int foodAndBeverageTotal = 0;
  int convenienceFee = 500;
  int movieTicketPriceTotal = 2000;
  int totalPrice = 0;
  @override
  void initState() {
    _calcTotalPrice();
  }
  void _calcTotalPrice(){
    foodAndBeverageTotal = 0;
    totalPrice = 0;
    this.widget.mSnackList?.forEach((element) {
      foodAndBeverageTotal += (element.price ?? 0) * (element.quantity ?? 1);
      totalPrice = foodAndBeverageTotal + movieTicketPriceTotal + convenienceFee;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Container(
          child: Text(
            CHECKOUT_TITLE,
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
                  height: 600,
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
                                  MovieTitleView(this.widget.mMovie),
                                  SizedBox(height: MARGIN_SMALL),
                                  CinemaTitleView(this.widget.mCinema),
                                  SizedBox(height: MARGIN_SMALL),
                                  DateTimeLocationView(bookingDate:this.widget.bookingDate ?? "",movieStartTime: this.widget.cinemaTimeSlot?.startTime ?? "",cinemaId: this.widget.mCinema?.id ?? 0,),
                                  SizedBox(height: MARGIN_SMALL),
                                  TicketPriceView(quantity: 1, toalTicketPrice : movieTicketPriceTotal),
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
                        padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                        child: FoodAndBeveragePriceView(this.widget.mSnackList,this.foodAndBeverageTotal,(snackId){
                          setState(() {
                            this.widget.mSnackList?.removeWhere((element) => element.id == snackId);
                            _calcTotalPrice();
                          });
                        }),
                      ),
                    ),
                    CornerSeparator(30, Colors.transparent),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Padding(
                        padding: EdgeInsets.all(MARGIN_MEDIUM),
                        child: Column(
                          children: [
                            ConvenienceFeeView(convenienceFee,() {
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
                            TotalPriceView(totalPrice),
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
    List<CSnackVO> snackList = [];
    snackList = this.widget.mSnackList?.map((snack) => CSnackVO(snack.id ?? 0, null, null, null, null, null, snack?.quantity ?? 1, null)).toList() ?? [];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage(mMovie: this.widget.mMovie,mCinema: this.widget.mCinema,mSnackList: snackList,cinemaDayTimeslotId: this.widget.cinemaTimeSlot?.id ?? 0,bookingDate: this.widget.bookingDate,)),
    );
  }
}

class TotalPriceView extends StatelessWidget {
  final int totalPrice;
  TotalPriceView(this.totalPrice);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "Total",
            style: TextStyle(
              color: ConfigClass.themeColor,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Text(
            "${totalPrice}Ks",
            style: TextStyle(
                color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ConvenienceFeeView extends StatelessWidget {
  final int convenienceFee;
  Function onTappedCancelationPolicy;
  ConvenienceFeeView(this.convenienceFee,this.onTappedCancelationPolicy);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                CONVENIENCE_FEE,
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
                "${convenienceFee}Ks",
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
  final List<SnackVO>? mSnackList;
  final int snacksTotalPrice;
  Function(int) onTappedRemoveSnack;

  FoodAndBeveragePriceView(this.mSnackList,this.snacksTotalPrice,this.onTappedRemoveSnack);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodAndBeverageTotalPriceTitleView(snacksTotalPrice),
        SizedBox(height: MARGIN_SMALL),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: mSnackList?.length ?? 0,
            itemBuilder: (BuildContext context , int index) {
          return FoodItemTicketPriceView(mSnackList?[index],(snackId) => onTappedRemoveSnack(snackId));
        }),
      ],
    );
  }
}

class TicketPriceView extends StatelessWidget {
  final int toalTicketPrice;
  final int quantity;
  TicketPriceView({required this.quantity,required this.toalTicketPrice});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "M-Tickets(${quantity})",
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
              "${toalTicketPrice}Ks",
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
    return DesignButtonView("Continue", THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR], ()=>onTappedContinue());
  }
}

class CinemaTitleView extends StatelessWidget {
  final CinemaVO? mCinema;
  CinemaTitleView(this.mCinema);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${mCinema?.name}",
          style: TextStyle(
            color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
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
  final MovieVO? mMovie;
  MovieTitleView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${mMovie?.title}",
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
  final int snackTotalPrice;
  FoodAndBeverageTotalPriceTitleView(this.snackTotalPrice);
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
        FOOD_AND_BEVERAGE_TITLE,
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
        "${snackTotalPrice}Ks",
        style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
