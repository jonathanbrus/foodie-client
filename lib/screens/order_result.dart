import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screens/orders.dart';

class OrderResultScreen extends StatelessWidget {
  const OrderResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, OrdersScreen.routeName,
          (route) => route.settings.name == "/home");
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
