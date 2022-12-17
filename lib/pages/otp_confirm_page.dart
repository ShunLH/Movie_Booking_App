import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/pages/pick_region_page.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../config/config_values.dart';
import '../config/environment_config.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class OTPConfirmPage extends StatefulWidget {
  final String phoneNumber;

  OTPConfirmPage(this.phoneNumber);

  @override
  State<OTPConfirmPage> createState() => _OTPConfirmPageState();

}

class _OTPConfirmPageState extends State<OTPConfirmPage> {
  MovieModel movieModel = MovieModelImpl();

  String otpCode = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ph number ${widget.phoneNumber}");
  }
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
                LogoImageView(),
                SizedBox(height: MARGIN_XXLARGE),
                Container(
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: Text(
                    WE_SENT_OTP_CODE_MESSAGE,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: Text(
                    ENTER_OTP_CODE_MESSAGE,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: TEXT_REGULAR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: MARGIN_XXLARGE),
                OTPTextFieldView((otp) {
                  setState(() {
                    this.otpCode = otp;
                  });
                }),
                Container(
                  margin: EdgeInsets.all(MARGIN_MEDIUM_2),
                  child: ConfirmOTPButtonView(
                      () => this._navigateToPickRegionView(context)),
                ),
              ],
            )),
      ),
    );
  }

  void _navigateToPickRegionView(BuildContext context) {
    print("phoneNumber ${widget.phoneNumber}");

    movieModel.signInWithPhone(widget.phoneNumber, "123456")?.then((response) {
      print("response ${response.code} ${response.data}");
      if (response.code == 201 && response.data != null) {
        DataRepository dataRepository = DataRepository();
        dataRepository.token = response.token;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PickRegionPage(),
            ));
      }else{
        showAboutDialog(context: context);
      }
    });
  }

  showAlertDialog(BuildContext context) {

    Widget continueButton = TextButton(
      child: Text("OK"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text("Invalid OTP, Try Again!!!"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class LogoImageView extends StatelessWidget {
  const LogoImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Logo.png',
      width: MediaQuery.of(context).size.width * 0.35,
      fit: BoxFit.fitWidth,
    );
  }
}

class OTPTextFieldView extends StatelessWidget {
  Function(String) onChangedOTPCode;
  OTPTextFieldView(this.onChangedOTPCode);
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      fillColor: Colors.white,
      fieldWidth: MediaQuery.of(context).size.width * 0.13,
      filled: true,
      showFieldAsBox: true,
      cursorColor: PRIMARY_COLOR,
      onCodeChanged: (String code) {
        this.onChangedOTPCode(code);
      },
    );
  }
}

class ConfirmOTPButtonView extends StatelessWidget {
  Function onTappedConfirm;
  ConfirmOTPButtonView(this.onTappedConfirm);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: BOOKING_BTN_HEIGHT,
      decoration: BoxDecoration(
        color: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
      ),
      child: TextButton(
        onPressed: () => this.onTappedConfirm(),
        child: Text(
          CONFIRM_OTP,
          style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
