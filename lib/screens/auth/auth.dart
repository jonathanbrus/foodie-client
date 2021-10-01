import 'package:flutter/material.dart';

import './signIn.dart';
import './signUp.dart';

enum loginOption { SignIn, SignUp, ManagerSignIn }

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  loginOption _loginOption = loginOption.SignIn;

  Widget get renderedOption {
    switch (_loginOption) {
      case loginOption.SignIn:
        return SignInScreen();

      case loginOption.SignUp:
        return SignUpScreen();

      default:
        return SignInScreen();
    }
  }

  void setSignInUp() {
    if (_loginOption == loginOption.SignIn) {
      setState(() {
        _loginOption = loginOption.SignUp;
      });
    } else {
      setState(() {
        _loginOption = loginOption.SignIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.top,
            child: Stack(
              children: [
                Positioned(
                  bottom: -90,
                  left: -90,
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200),
                        topRight: Radius.circular(200),
                        bottomLeft: Radius.circular(260),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  top: mediaQuery.size.height * 0.16,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: renderedOption,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _loginOption == loginOption.SignIn
                                ? "New user? "
                                : "Already an user? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black.withOpacity(0.2),
                            ),
                            onPressed: setSignInUp,
                            child: Text(
                              _loginOption == loginOption.SignIn
                                  ? "Sign Up."
                                  : "Sign In ",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -140,
                  right: -120,
                  child: Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(170),
                        bottomRight: Radius.circular(170),
                        bottomLeft: Radius.circular(170),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  top: -100,
                  right: -86,
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(150),
                        bottomRight: Radius.circular(150),
                        bottomLeft: Radius.circular(150),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 16,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "assets/appIcon.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
