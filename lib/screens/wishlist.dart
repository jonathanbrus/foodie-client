import 'package:flutter/material.dart';

import '../widgets/double_back.dart';
import '../widgets/bottom_navigation.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = "/wishlist";
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("WishList"),
      ),
      body: DoubleBack(
        child: Center(
          child: SizedBox(
            width: 160,
            height: 200,
            child: Image.asset(
              "assets/wishlist.png",
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(index: 2),
    );
  }
}
