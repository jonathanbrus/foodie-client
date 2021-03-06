import 'package:flutter/material.dart';

// Foodie Screens
import '../foodie/screens/home.dart';
import '../foodie/screens/restaurant.dart';
import '../foodie/screens/cart.dart';

// Screens
import '../screens/auth/auth.dart';
import '../screens/auth/verify_otp.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/my_addresses.dart';
import '../screens/add_address.dart';
import '../screens/products.dart';
import '../screens/product_details.dart';
import '../screens/wishlist.dart';
import '../screens/cart.dart';
import '../screens/orders.dart';
import '../screens/order_details.dart';
import '../screens/payments.dart';

import '../screens/general/about_us.dart';
import '../screens/general/terms_and_conditions.dart';
import '../screens/general/privacy_policy.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => AuthScreen());

      case OtpVerifyScreen.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => OtpVerifyScreen(
              from: args[0],
              phone: args[1],
            ),
          );
        }
        return _errorRoute();

      case FoodieHome.routeName:
        return MaterialPageRoute(builder: (ctx) => FoodieHome());

      case Restaurant.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => Restaurant(
              id: args[0].toString(),
              name: args[1].toString(),
              image: args[2].toString(),
              distance: args[3],
            ),
          );
        }
        return _errorRoute();

      case FoodieCheckOut.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => FoodieCheckOut(),
          );
        }
        return _errorRoute();

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => HomeScreen());

      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => ProfileScreen());

      case MyAddressesScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => MyAddressesScreen());

      case AddAddressScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => AddAddressScreen());

      case ProductsScreen.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => ProductsScreen(
              title: args[0],
              category: args[1],
            ),
          );
        }
        return _errorRoute();

      case ProductDetailsScreen.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => ProductDetailsScreen(
              product: args[0],
            ),
          );
        }
        return _errorRoute();

      case WishListScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => WishListScreen());

      case CartScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => CartScreen());

      case OrdersScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => OrdersScreen());

      case OrderDetailsScreen.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => OrderDetailsScreen(
              orderId: args[0],
            ),
          );
        }
        return _errorRoute();

      case PaymentsScreen.routeName:
        if (args is List) {
          return MaterialPageRoute(
            builder: (ctx) => PaymentsScreen(
              addressIndex: args[0],
              food: args[1],
            ),
          );
        }
        return _errorRoute();

      case AboutUsScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => AboutUsScreen());

      case TermsScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => TermsScreen());

      case PrivacyPolicyScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => PrivacyPolicyScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("error"),
        ),
        body: Center(
          child: Text("error"),
        ),
      );
    });
  }
}
