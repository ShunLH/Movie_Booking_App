import 'package:flutter/material.dart';
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/pages/pick_region_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: MARGIN_XXLARGE),
                Container(
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: Expanded(
                    child: Text(
                      VERIFY_YOUR_PHONE_NUMBER,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_REGULAR_3X,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: Expanded(
                    child: Text(
                      SEND_6DIGIT_NUMBER_CODE_MESSAGE,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_REGULAR,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: MARGIN_XXLARGE),
                MobilePhoneView(),
                Container(
                  margin: EdgeInsets.all(MARGIN_MEDIUM_2),
                  child: VerifyYourAccountButtonView(() => this._navigateToPickRegionView(context)),
                ),
                Container(
                  margin: EdgeInsets.all(MARGIN_MEDIUM_2),
                  child: SignInWithGoogleView(() => this._navigateToPickRegionView(context)),
                )
              ],
            )),
      ),
    );
  }
  void _navigateToPickRegionView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PickRegionPage(),
        ));
  }
}

class MobilePhoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MARGIN_MEDIUM_2),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width : MediaQuery.of(context).size.width * 0.25,
            child: Stack(children : [
              Positioned.fill(child:  CountryCodeInputTextField()),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: ICON_MEDIUM_SIZE,
                  color: DARK_GRAY_TEXT_COLOR,
                ),
              )
            ]),
          ),
          Spacer(),
          Container(
            width : MediaQuery.of(context).size.width * 0.6,
            child: MobileNumberInputTextField(),
          ),

        ],
      ),
    );
  }
}
class SignInWithGoogleView extends StatelessWidget {
  Function onTappedButton;
  SignInWithGoogleView(this.onTappedButton);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: BOOKING_BTN_HEIGHT,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
      ),
      child: Positioned.fill(
        child: TextButton(
          onPressed: () => this.onTappedButton(),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google_logo.png"),
                SizedBox(width: MARGIN_MEDIUM,),
                Text(CONTINUE_WITH_GOOGLE,style: TextStyle(
                    color: Colors.black,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w600

                ),),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class VerifyYourAccountButtonView extends StatelessWidget {
  Function onTappedVerify;
  VerifyYourAccountButtonView(this.onTappedVerify);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: BOOKING_BTN_HEIGHT,
      decoration: BoxDecoration(
        color: THEME_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
      ),
      child: Positioned.fill(
        child: TextButton(
          onPressed: () => this.onTappedVerify(),
          child: Text(VERIFY_YOUR_PHONE_NUMBER,style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w600

          ),),
        ),
      ),

    );
  }
}
class CountryCodeInputTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: true,
      autofocus: true,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: GRAY_TEXT_COLOR),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: GRAY_TEXT_COLOR),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: "+95",
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w600,
        ),
        labelText: COUNTRY_CODE,
        labelStyle: TextStyle(
          color: GRAY_TEXT_COLOR,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w600,
        ),

      ),
    );
  }
}


class MobileNumberInputTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: true,
      autofocus: false,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: GRAY_TEXT_COLOR),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: GRAY_TEXT_COLOR),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: MOBILE_NUMBER,
        hintStyle: TextStyle(
          color: GRAY_TEXT_COLOR,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
