import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderResultScreen extends StatelessWidget {
  const OrderResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 360,
          child: Lottie.asset("assets/lottie/success.json"),
        ),
      ),
    );
  }
}
