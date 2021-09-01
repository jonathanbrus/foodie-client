import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';

import '../../screens/home.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/sign-up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();

  bool _loader = false;

  Map<String, dynamic> _newUser = {
    "name": "",
    "email": "",
    "phone": "",
    "password": "",
    "confirmPassword": ""
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
      await Provider.of<Auth>(context, listen: false).signUp(
        name: _newUser["name"].trim(),
        email: _newUser["email"].trim(),
        phone: _newUser["phone"].trim(),
        password: _newUser["password"].trim(),
      );
      setState(() {
        _loader = false;
      });

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
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _newUser["name"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "name cannot be empty";
                  }
                  if (value.length < 4) {
                    return "name must be atleast 4 character long";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _newUser["email"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email cannot be empty";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _newUser["phone"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "phone number cannot be empty";
                  }
                  if (value.length != 10) {
                    return "enter proper phone number";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onSaved: (value) {
                  _newUser["password"] = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password cannot be empty";
                  }
                  if (value.length < 6) {
                    return "password must be atleast 6 character long";
                  }
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: "Confirm Password"),
              //   keyboardType: TextInputType.visiblePassword,
              //   obscureText: true,
              //   onFieldSubmitted: (_) {
              //     _submitForm(context);
              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "password cannot be empty";
              //     }
              //     if (_newUser["password"] != _newUser["confirmPassword"]) {
              //       return "passwords do not match";
              //     }
              //   },
              // ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: () => _submitForm(context),
                  icon: Icon(Icons.login_rounded),
                  label: Text("Sign Up"),
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
            ],
          ),
        ],
      ),
    );
  }
}
