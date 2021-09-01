import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class DoubleBack extends StatelessWidget {
  final Widget child;
  const DoubleBack({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      snackBar: SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Press again to exit"),
        width: 152,
        duration: Duration(milliseconds: 1400),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: child,
    );
  }
}
