import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import './providers/user.dart';
import './foodie/providers/restaurants.dart';
import './foodie/providers/foods.dart';
import './foodie/providers/cart.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

//Routes
import './helpers/route_generator.dart';

// screens
import './screens/home.dart';
import './screens/auth/auth.dart';

import './constants/theme_data.dart';

GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: User()),
        ChangeNotifierProvider.value(value: Restaurants()),
        ChangeNotifierProvider.value(value: Foods()),
        ChangeNotifierProvider.value(value: FoodieCart()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        navigatorKey: navState,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        scrollBehavior: ConstantScrollBehavior(),
        home: Consumer<User>(
          builder: (ctx, user, ch) => FutureBuilder<bool>(
            future: user.autoLogin(),
            builder: (ctx, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data == true ? HomeScreen() : AuthScreen();
              } else {
                return AuthScreen();
              }
            },
          ),
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
