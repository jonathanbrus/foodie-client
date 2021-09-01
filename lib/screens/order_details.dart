import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = "/order-details";
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Text("Order Detail Screen"),
      ),
    );
  }
}
