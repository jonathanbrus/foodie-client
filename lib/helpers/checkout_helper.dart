import 'package:alofoodie/foodie/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../foodie/providers/cart.dart';
import '../providers/user.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

import '../screens/order_result.dart';

import '../widgets/select_address.dart';
import '../widgets/show_price_detail.dart';

class BottomContainer extends StatefulWidget {
  final List cartItems;
  final bool food;
  final int cartItemsAmount;
  final int taxAmount;
  final int packagingCharge;
  final int deliveryCharge;
  final int freeDeliveryMargin;
  final Function clearCart;

  BottomContainer({
    required this.cartItems,
    required this.food,
    required this.cartItemsAmount,
    required this.taxAmount,
    required this.packagingCharge,
    required this.deliveryCharge,
    required this.freeDeliveryMargin,
    required this.clearCart,
    Key? key,
  }) : super(key: key);

  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.cartItemsAmount +
        widget.packagingCharge +
        widget.taxAmount +
        (widget.cartItemsAmount > widget.freeDeliveryMargin
            ? 0
            : widget.deliveryCharge);

    return Container(
      height: 60,
      color: Colors.white,
      child: Consumer<User>(
        builder: (ctx, auth, _) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Rs.$totalAmount",
                          style: TextStyle(
                            fontSize: 15.4,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => showPriceDetail(
                        context: context,
                        food: widget.food,
                        freeDeliveryMargin: widget.freeDeliveryMargin,
                        deliveryCharge: widget.deliveryCharge,
                        itemsAmount: widget.cartItemsAmount,
                        noOfItems: widget.cartItems.length,
                        packagingCharge: widget.packagingCharge,
                        taxAmount: widget.taxAmount,
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  shadowColor: Colors.transparent,
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: widget.cartItems.length == 0
                    ? null
                    : () => showSelectAddress(context, widget.food),
                child: Row(
                  children: [
                    Text(
                      "Select Address",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FreeDeliveryCard extends StatelessWidget {
  final String text;
  const FreeDeliveryCard({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(left: 8, top: 6, right: 8, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          gradient: RadialGradient(
            colors: [
              Color(0xffF2BB15),
              Color(0xfffffc00),
            ],
            focal: Alignment.center,
            radius: 10,
            focalRadius: 0.8,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CashLessPayNotice extends StatelessWidget {
  const CashLessPayNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Now you can make cashless payments with Gpay, Phonepe and other cards on your doorstep.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "For more queries contact +91 87787 96511",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}

void placeOrder({
  required BuildContext context,
  required bool food,
  required int addressIndex,
  required Function setLoader,
}) async {
  final user = Provider.of<User>(context, listen: false);
  final cart = Provider.of<Cart>(context, listen: false);
  final foodieCart = Provider.of<FoodieCart>(context, listen: false);

  final buyFrom = food ? foodieCart.restaurantName : "AloFoodie";
  final address = user.addresses[addressIndex];
  final List<CartItem> orderItems =
      food ? foodieCart.cartItems : cart.getAllProducts;
  final Function clearCart = food ? foodieCart.clearCart : cart.clearCart;
  final packingCharge = food ? foodieCart.packagingCharge : 0;
  final deliveryCharge = food ? foodieCart.deliveryCharge : cart.deliveryCharge;
  final taxAmount = food ? foodieCart.taxAmount : cart.taxAmount;
  final cartItemsAmount =
      food ? foodieCart.totalItemsAmount : cart.totalItemsAmount;

  if (cartItemsAmount <= 199 && !food) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 1000),
        content: Text("Order value must be minimum  \u{20B9}199."),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Okay",
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );

    return;
  }

  setLoader();
  try {
    await Provider.of<Orders>(context, listen: false).placeOrder(
      food: food,
      buyFrom: buyFrom,
      orderItems: orderItems
          .map((item) => OrderItem(
                name: item.name,
                image: item.image,
                price: item.offerPrice,
                quantity: item.quantity,
                addon: item.addon,
                topping: item.topping,
                bun: item.bun,
                size: item.size,
              ))
          .toList(),
      shippingAddress: {
        "fullName": address.fullName,
        "phone": address.phone,
        "pincode": address.pincode,
        "address": address.address,
        "city": address.city,
        "state": address.state,
      },
      paymentMethod: "COD",
      taxAmount: taxAmount.toInt(),
      deliveryCharge: deliveryCharge,
      packingCharge: packingCharge,
      totalAmount: cartItemsAmount + taxAmount + deliveryCharge + packingCharge,
      token: user.authToken,
    );
    clearCart();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OrderResultScreen(),
      ),
    );
    setLoader();
  } catch (e) {
    print(e);
    setLoader(false);
  }
}
