import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';

import '../../screens/home.dart';
// import '../../screens/auth/verify_otp.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/sign-in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _form = GlobalKey<FormState>();
  bool _toggle = false;

  bool _loader = false;

  Map<String, dynamic> _detail = {
    "email": "",
    "password": "",
  };

  _submitForm(context) async {
    bool isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _loader = true;
    });

    try {
      await Provider.of<User>(context, listen: false).signIn(
        email: _detail["email"].trim(),
        password: _detail["password"].trim(),
      );

      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (e) {
      setState(() {
        _loader = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          action: SnackBarAction(
            label: "Okay",
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            textColor: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Stack(
        children: [
          if (_loader)
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white.withOpacity(0.2),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _detail["email"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email cannot be empty";
                  }
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                    child: Icon(
                      _toggle
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: 26,
                    ),
                  ),
                ),
                obscureText: !_toggle,
                onSaved: (value) {
                  _detail["password"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password cannot be empty";
                  }
                },
                onFieldSubmitted: (_) => _submitForm(context),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: () => _submitForm(context),
                  icon: Icon(Icons.login_rounded),
                  label: Text("Sign In"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6),
              // GestureDetector(
              //   onTap: () => Navigator.of(context).pushNamed(
              //     OtpVerifyScreen.routeName,
              //     arguments: ["forgotPassword", ""],
              //   ),
              //   child: Text(
              //     "Forgot Password",
              //     style: TextStyle(
              //       fontSize: 12,
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
