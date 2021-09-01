import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  static const routeName = "/payments";
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
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
        child: Text("Payments Screen"),
      ),
    );
  }
}
