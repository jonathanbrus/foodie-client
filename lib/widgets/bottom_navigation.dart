import 'package:flutter/material.dart';

//screens
import '../screens/home.dart';
import '../screens/wishlist.dart';
// import '../screens/cart.dart';
import '../screens/orders.dart';
import '../screens/profile.dart';

class BottomNavigator extends StatefulWidget {
  final int index;
  const BottomNavigator({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  var _activeIndex;
  @override
  void initState() {
    _activeIndex = widget.index;
    super.initState();
  }

  void setIndex(int i) {
    setState(() {
      _activeIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            activeIndex: _activeIndex,
            index: 1,
            title: "Home",
            to: HomeScreen.routeName,
            icon: Icons.home_filled,
            setIndex: setIndex,
          ),
          BottomNavItem(
            activeIndex: _activeIndex,
            index: 2,
            title: "Wishlist",
            to: WishListScreen.routeName,
            icon: Icons.favorite_rounded,
            setIndex: setIndex,
          ),
          // BottomNavItem(
          //   activeIndex: _activeIndex,
          //   index: 3,
          //   title: "Cart",
          //   to: CartScreen.routeName,
          //   icon: Icons.shopping_bag,
          //   setIndex: setIndex,
          // ),
          BottomNavItem(
            activeIndex: _activeIndex,
            index: 3,
            title: "Orders",
            to: OrdersScreen.routeName,
            icon: Icons.history_rounded,
            setIndex: setIndex,
          ),
          BottomNavItem(
            activeIndex: _activeIndex,
            index: 4,
            title: "Profile",
            to: ProfileScreen.routeName,
            icon: Icons.person,
            setIndex: setIndex,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final int activeIndex;
  final int index;
  final String title;
  final String to;
  final IconData icon;
  final Function setIndex;

  BottomNavItem({
    Key? key,
    required this.activeIndex,
    required this.index,
    required this.title,
    required this.to,
    required this.icon,
    required this.setIndex,
  }) : super(key: key);

  bool isActive() {
    return activeIndex == index;
  }

  void navigateToPage(BuildContext context) {
    setIndex(index);

    Navigator.of(context).pushNamed(to);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToPage(context),
      child: Container(
        width: 50,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                icon,
                color:
                    isActive() ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 150),
              child: Text(title),
              style: isActive()
                  ? TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                    )
                  : TextStyle(
                      color: Colors.grey,
                      fontSize: 0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
