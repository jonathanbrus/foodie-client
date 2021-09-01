import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

// import '../../../providers/auth.dart';

import '../../../helpers/checkout_helper.dart';

import '../../ui_widgets/price_detail.dart';
import '../../ui_widgets/food_item.dart';

//screen
// import '../../screens/my_addresses.dart';

class FoodieCheckOut extends StatefulWidget {
  static const routeName = "/food-checkout";
  final String restaurantName;
  final int deliveryCharge;

  const FoodieCheckOut({
    required this.restaurantName,
    required this.deliveryCharge,
    Key? key,
  }) : super(key: key);

  @override
  _FoodieCheckOutState createState() => _FoodieCheckOutState();
}

class _FoodieCheckOutState extends State<FoodieCheckOut> {
  bool _loader = false;

  int _selectedAddress = 0;

  void selectAddress(int index) {
    setState(() {
      _selectedAddress = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodieCartProvider = Provider.of<FoodieCart>(context);
    final deliveryCharge =
        foodieCartProvider.itemsAmount > 999 ? 0 : widget.deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ...foodieCartProvider.cartItems.map(
                  (cartItem) => FoodItem(
                    id: cartItem.id,
                    name: cartItem.name,
                    image: cartItem.image,
                    description: cartItem.name,
                    fixedPrice: cartItem.fixedPrice,
                    offerPrice: cartItem.offerPrice,
                    packagingCharge: cartItem.packagingCharge,
                    quantity: cartItem.quantity,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  color: Colors.white,
                  child: Text(
                    "Free delivery for orders above Rs.999",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                PriceDetail(
                  from: "Food",
                  noOfItems: foodieCartProvider.cartItems.length,
                  itemsAmount: foodieCartProvider.itemsAmount,
                  taxAmount: foodieCartProvider.taxAmount,
                  packagingCharge: foodieCartProvider.packagingCharge,
                  deliveryCharge: deliveryCharge,
                  freeDeliveryMargin: 999,
                ),
                // Container(
                //   width: double.infinity,
                //   color: Colors.white,
                //   padding: EdgeInsets.all(6),
                //   margin: EdgeInsets.only(bottom: 10),
                //   alignment: Alignment.center,
                //   child: Column(
                //     children: [
                //       Text(
                //         "Now you can make cashless payments with Gpay, Phonepe and other cards when receiving your order.",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontSize: 15),
                //       ),
                //       Text(
                //         "For more queries contact +91 87787 96511",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontSize: 15),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomContainer(
        cartItems: [...foodieCartProvider.cartItems],
        buyFrom: widget.restaurantName,
        isFood: true,
        cartItemsAmount: foodieCartProvider.itemsAmount,
        taxAmount: foodieCartProvider.taxAmount,
        packagingCharge: foodieCartProvider.packagingCharge,
        deliveryCharge: deliveryCharge,
        freeDeliveryMargin: 999,
        loader: _loader,
        setLoader: (bool val) {
          setState(() {
            _loader = val;
          });
        },
        selectedAddress: _selectedAddress,
        clearCart: foodieCartProvider.clearCart,
      ),
    );
  }
}
