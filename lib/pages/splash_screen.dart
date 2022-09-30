import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../main.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {_navigateToHome(context);},
      child: Container(
        color: PRIMARY_COLOR,
        child: Image.asset(
          'assets/images/Logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieApp(city: null)));
  }
}
