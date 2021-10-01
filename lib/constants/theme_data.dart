import 'package:flutter/material.dart';

import '../helpers/route_animation.dart';

ThemeData themeData = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0.5,
    color: Color(0xffF2BB13),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  fontFamily: "OpenSans",
  backgroundColor: Color(0xffF2BB13),
  primaryColor: Color(0xffF2BB13),
  colorScheme: ThemeData().colorScheme.copyWith(secondary: Color(0xff000000)),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomRouteTransitionBuilder(),
      TargetPlatform.iOS: CustomRouteTransitionBuilder(),
    },
  ),
);
