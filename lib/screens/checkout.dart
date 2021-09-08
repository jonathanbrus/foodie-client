import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/my_addresses.dart';

import '../../../providers/cart.dart';
import '../providers/user.dart';

import '../../../helpers/checkout_helper.dart';

import '../ui_widgets/items_summary.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = "/summary-and-checkout";
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Checkout"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<User>(
                    builder: (ctx, user, ch) {
                      if (user.addresses.length <= 0) {
                        return Container(
                          width: double.infinity,
                          child: Text(
                            "No Address Added",
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.addresses[0].fullName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.addresses[0].phone.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              user.addresses[0].address +
                                  user.addresses[0].address,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              user.addresses[0].city +
                                  "-" +
                                  user.addresses[0].pincode.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              user.addresses[0].state,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).accentColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(MyAddressesScreen.routeName),
                      child: Text(
                        "Change or Add Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ItemsSummary(cartItems: cartProvider.getAllProducts),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Text(
                "Free delivery for orders above Rs.499",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Now you can make cashless payments with Gpay, Phonepe and other cards when receiving your order.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "For more queries contact +91 87787 96511",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomContainer(
        cartItems: [...cartProvider.getAllProducts],
        buyFrom: "Alo Foodie",
        isFood: false,
        cartItemsAmount: cartProvider.totalItemsAmount,
        taxAmount: cartProvider.taxAmount,
        packagingCharge: 0,
        deliveryCharge: cartProvider.deliveryCharge,
        freeDeliveryMargin: 499,
        // loader: _loader,
        // setLoader: (bool val) {
        //   setState(() {
        //     _loader = val;
        //   });
        // },
        // selectedAddress: _selectedAddress,
        clearCart: () {
          cartProvider.clearCart();
        },
      ),
    );
  }
}
