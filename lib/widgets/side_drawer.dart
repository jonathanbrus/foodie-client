import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:in_app_review_platform_interface/in_app_review_platform_interface.dart';

import '../screens/home.dart';
import '../screens/orders.dart';
import '../screens/cart.dart';
import '../screens/wishlist.dart';
import '../screens/general/about_us.dart';
import '../screens/general/terms_and_conditions.dart';
import '../screens/general/privacy_policy.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Header(),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("Home"),
            leading: Icon(Icons.home_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(HomeScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("My Orders"),
            leading: Icon(Icons.history_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(OrdersScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("My Cart"),
            leading: Icon(Icons.shopping_cart_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(CartScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("My WishList"),
            leading: Icon(Icons.favorite_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(WishListScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("About Us"),
            leading: Icon(Icons.info_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(AboutUsScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("Terms & Conditions"),
            leading: Icon(Icons.document_scanner_rounded),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(TermsScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("Privacy Policy"),
            leading: Icon(Icons.group_rounded),
            onTap: () => Navigator.of(context)
                .popAndPushNamed(PrivacyPolicyScreen.routeName),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("Rate App"),
            leading: Icon(Icons.rate_review_rounded),
            onTap: () => print("object"),
          ),
          ListTile(
            horizontalTitleGap: 0,
            title: Text("Share App"),
            leading: Icon(Icons.share_rounded),
            onTap: () => Share.share(
              "Check out this amazing online food delivery app. https://play.google.com/store/apps/details?id=com.ALO_Foodie_alo_foodie",
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.only(top: 30, bottom: 10, left: 16, right: 16),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Hey,",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Alo Foodie User",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "jonathanbrus966@gmail.com",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
