import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './cart.dart';

import '../foodie/screens/foodie_home.dart';
import '../screens/products.dart';

//widgets
import '../widgets/double_back.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/banner.dart';
import '../widgets/home_carousal.dart';
import '../widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> handlePush() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data["category"] == "food") {
      Navigator.of(context).pushNamed(FoodieHome.routeName);
    } else {
      Navigator.of(context).pushNamed(
        ProductsScreen.routeName,
        arguments: [
          message.data["title"],
          message.data["category"],
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();

    handlePush();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final screenHeight =
        mediaQuery.size.height - mediaQuery.viewInsets.horizontal;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Alo Foodie"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(CartScreen.routeName),
            icon: Icon(Icons.shopping_cart_rounded),
          )
        ],
      ),
      body: DoubleBack(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeCarousel(screenHeight: screenHeight),
                CategoriesSection(),
                CustomBanner(),
                // Container(
                //   width: double.infinity,
                //   height: 220,
                //   margin: EdgeInsets.symmetric(vertical: 2),
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       Container(
                //         width: 200,
                //         height: 220,
                //         padding: EdgeInsets.all(2),
                //         margin: EdgeInsets.only(right: 2),
                //         color: Colors.white,
                //         child: Image.asset(
                //           "assets/kcs.png",
                //           fit: BoxFit.cover,
                //           alignment: Alignment.bottomCenter,
                //         ),
                //       ),
                //       Container(
                //         width: 200,
                //         height: 220,
                //         padding: EdgeInsets.all(2),
                //         margin: EdgeInsets.only(right: 2),
                //         color: Colors.white,
                //         child: Image.asset(
                //           "assets/lcs.png",
                //           fit: BoxFit.cover,
                //           alignment: Alignment.bottomCenter,
                //         ),
                //       ),
                //       Container(
                //         width: 200,
                //         height: 220,
                //         padding: EdgeInsets.all(2),
                //         margin: EdgeInsets.only(right: 2),
                //         color: Colors.white,
                //         child: Image.asset(
                //           "assets/mcs.png",
                //           fit: BoxFit.cover,
                //           alignment: Alignment.bottomCenter,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3),
                    ),
                    child: Text(
                      "WE DO NOT ASK FOR YOUR BANK ACCOUNT OR CARD DETAILS VERBALLY OR TELEPHONICALLY. DO NOT DIVULGE THESE TO FRAUDSTERS & IMPOSTERS CLAIMING TO BE CALLING ON OUR BEHALF.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(index: 1),
    );
  }
}