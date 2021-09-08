import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

import '../../../helpers/checkout_helper.dart';

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
  @override
  Widget build(BuildContext context) {
    final foodieCartProvider = Provider.of<FoodieCart>(context);
    final deliveryCharge =
        foodieCartProvider.itemsAmount > 999 ? 0 : widget.deliveryCharge;

    if (foodieCartProvider.cartItems.length == 0) {
      Future.delayed(Duration(milliseconds: 150), () {
        Navigator.of(context).pop();
      });
    }

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
                SizedBox(height: 8),
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
                FreeDeliveryCard(text: "Free delivery for orders above Rs.999"),
                CashLessPayNotice(),
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
        clearCart: foodieCartProvider.clearCart,
      ),
    );
  }
}
