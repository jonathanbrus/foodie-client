import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:share_plus/share_plus.dart';

import './cart.dart';

import '../foodie/screens/home.dart';
import '../screens/products.dart';

//widgets
import '../ui_widgets/home_carousal.dart';

import '../widgets/double_back.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/banner.dart';
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
    if (message.data["category"] != null &&
        message.data["category"] == "food") {
      Navigator.of(context).pushNamed(FoodieHome.routeName);
    }
    if (message.data["category"] != null) {
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
            splashColor: Colors.amber,
            splashRadius: 28,
          )
        ],
      ),
      body: DoubleBack(
        child: SafeArea(
          child: ListView(
            children: [
              HomeCarousel(
                uri: "home",
                screenHeight: screenHeight,
              ),
              CategoriesSection(),
              CustomBanner(),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Share Our App",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.048,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () => Share.share(
                    "Check out this amazing online delivery app. https://play.google.com/store/apps/details?id=com.ALO_Foodie_alo_foodie , Alofoodie delivers food and other products all over kanyakumari district at best price.",
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset("assets/poster.jpeg"),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "WE DO NOT ASK FOR YOUR BANK ACCOUNT OR CARD DETAILS VERBALLY OR TELEPHONICALLY. DO NOT DIVULGE THESE TO FRAUDSTERS & IMPOSTERS CLAIMING TO BE CALLING ON OUR BEHALF.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(index: 1),
    );
  }
}
