import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/pages/home_page.dart';

import '../data/models/data_repository.dart';
import '../data/models/movie_model.dart';
import '../data/vos/city_vo.dart';
import '../main.dart';

class ConfirmSuccessPage extends StatefulWidget {
  const ConfirmSuccessPage({Key? key}) : super(key: key);

  @override
  State<ConfirmSuccessPage> createState() => _ConfirmSuccessPageState();
}

class _ConfirmSuccessPageState extends State<ConfirmSuccessPage> {
  MovieModel mMovieModel = MovieModelImpl();
  CityVO? location;

  @override
  void initState() {
    super.initState();
    location = mMovieModel.getLoginUser()?.selectedCity ?? CityVO(1, "YGN", null, null, false);
    Future.delayed(Duration(seconds: 5), (){
      print("Executed after  3 seconds");

      // Navigator.popUntil(context, (route) => false)
      // Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MovieApp(city:location)), (Route<dynamic> route) => false);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Image.asset("assets/images/success_illustration.png",fit: BoxFit.fitWidth,),
      ),
    );
  }
}
