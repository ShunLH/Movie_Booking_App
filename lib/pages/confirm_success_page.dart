import 'package:flutter/material.dart';

class ConfirmSuccessPage extends StatefulWidget {
  const ConfirmSuccessPage({Key? key}) : super(key: key);

  @override
  State<ConfirmSuccessPage> createState() => _ConfirmSuccessPageState();
}

class _ConfirmSuccessPageState extends State<ConfirmSuccessPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), (){
      print("Executed after  3 seconds");
      // Navigator.popUntil(context, (route) => false)
      Navigator.popUntil(context, ModalRoute.withName('/'));

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
