import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

import '../../../helpers/checkout_helper.dart';

import '../widgets/cart_item.dart';

class FoodieCheckOut extends StatefulWidget {
  static const routeName = "/food-checkout";

  const FoodieCheckOut({
    Key? key,
  }) : super(key: key);

  @override
  _FoodieCheckOutState createState() => _FoodieCheckOutState();
}

class _FoodieCheckOutState extends State<FoodieCheckOut> {
  @override
  Widget build(BuildContext context) {
    final foodieCartProvider = Provider.of<FoodieCart>(context);

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
                  (cartItem) => FoodCartItem(
                    cartItem: cartItem,
                  ),
                ),
                if (foodieCartProvider.cartItems.isEmpty)
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Check your orders in my orders page !",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
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
        food: true,
        cartItemsAmount: foodieCartProvider.totalItemsAmount,
        taxAmount: foodieCartProvider.taxAmount,
        packagingCharge: foodieCartProvider.packagingCharge,
        deliveryCharge: foodieCartProvider.deliveryCharge,
        freeDeliveryMargin: 999,
        clearCart: foodieCartProvider.clearCart,
      ),
    );
  }
}
