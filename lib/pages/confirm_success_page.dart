import 'package:flutter/material.dart';

class ConfirmSuccessPage extends StatelessWidget {
  const ConfirmSuccessPage({Key? key}) : super(key: key);

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
