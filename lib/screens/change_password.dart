import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "/change_password";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text("Change Password"),
          ],
        ),
      ),
    );
  }
}
