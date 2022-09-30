import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

class PaymentTypeView extends StatelessWidget {
  final PaymentTypeVO paymentType;
  Function onTappedPaymentType;

  PaymentTypeView(this.paymentType, this.onTappedPaymentType);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      padding: EdgeInsets.symmetric(vertical: MARGIN_XSMALL),
      child: GestureDetector(
        onTap: () => this.onTappedPaymentType(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
          ),
          child: Row(
            children: [
              // ImageIconView((paymentType.icon ?? ""),ICON_MEDIUM_SIZE,Colors.white,),
              Image.network(
                "${paymentType.icon ?? ""}",
                width: ICON_MEDIUM_SIZE,
                height: ICON_MEDIUM_SIZE,
                color: Colors.white,
              ),
              SizedBox(width: MARGIN_SMALL),
              TitleTextView(paymentType.title ?? ""),
              Spacer(),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: ICON_SMALL_SIZE)
            ],
          ),
        ),
      ),
    );
  }
}
