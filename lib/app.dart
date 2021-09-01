import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import './providers/auth.dart';
import './foodie/providers/restaurants.dart';
import './foodie/providers/foods.dart';
import './foodie/providers/cart.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

//Routes
import './helpers/route_generator.dart';

//Page Transition
import 'helpers/route_animation.dart';

// screens
import './screens/home.dart';
import './screens/auth/auth.dart';

GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Restaurants()),
        ChangeNotifierProvider.value(value: Foods()),
        ChangeNotifierProvider.value(value: FoodieCart()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, ch) {
          return MaterialApp(
            navigatorKey: navState,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0.5,
                color: Color(0xffF2BB13),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              fontFamily: "OpenSans",
              backgroundColor: Color(0xffF2BB13),
              primaryColor: Color(0xffF2BB13),
              accentColor: Color(0xff000000),
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomRouteTransitionBuilder(),
                  TargetPlatform.iOS: CustomRouteTransitionBuilder(),
                },
              ),
            ),
            scrollBehavior: ConstantScrollBehavior(),
            home: FutureBuilder<bool>(
              future: auth.autoLogin(),
              builder: (ctx, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data == true ? HomeScreen() : AuthScreen();
                } else {
                  return AuthScreen();
                }
              },
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
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
