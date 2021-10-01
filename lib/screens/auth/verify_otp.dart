import 'package:flutter/material.dart';
// import 'package:flutter_otp/flutter_otp.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../change_password.dart';

class OtpVerifyScreen extends StatefulWidget {
  static const routeName = "/verify-otp";
  final String from;
  final String phone;

  const OtpVerifyScreen({required this.from, required this.phone, Key? key})
      : super(key: key);

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _form = GlobalKey<FormState>();
  bool _userExist = false;

  void navigateToChangePassword() {
    if (widget.from == "forgotPassword") {
      Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
    }
  }

  void verifyOtp(BuildContext context) async {
    navigateToChangePassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              if (widget.from == "forgotPassword")
                Container(
                  margin: EdgeInsets.all(6),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintText: "example: +91 8956401923",
                      labelStyle: TextStyle(fontSize: 18),
                      hintStyle: TextStyle(fontSize: 14),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 4),
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send_rounded,
                      size: 18,
                    ),
                    label: Text(
                      "Send OTP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 6, top: 16),
                child: Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (String val) {},
                    enablePinAutofill: true,
                    textStyle: TextStyle(fontSize: 16),
                    pinTheme: PinTheme.defaults(
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.blue,
                      fieldHeight: 36,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _userExist ? () {} : null,
                    child: Text(
                      "Verify",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
