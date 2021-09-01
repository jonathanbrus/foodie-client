import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/order_result.dart';

import '../providers/auth.dart';
import '../providers/orders.dart';

List restricted = ["KFC", "Domino's", "Dindigul Thalappakatti"];

void submitForm({
  required BuildContext context,
  required String id,
  required String name,
  required bool isFood,
  required List orderItems,
  required int cartItemsAmount,
  required int taxAmount,
  required int packagingCharge,
  required int deliveryCharge,
  required String token,
  required String buyFrom,
  required int selectedAddress,
  required Function clearCart,
  required Function setLoader,
}) async {
  final addresses =
      Provider.of<Auth>(context, listen: false).userData.addresses;

  if (addresses.length <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Add address to place orders."),
      ),
    );
  } else if (restricted.contains(buyFrom) &&
      (DateTime.now().hour >= 21 || DateTime.now().hour <= 9)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Cannot deliver orders now."),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Okay",
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  } else {
    setLoader(true);
    try {
      await Provider.of<Orders>(context, listen: false).placeOrder(
        userId: id,
        isFood: isFood,
        buyFrom: buyFrom,
        orderItems: orderItems
            .map((e) => OrderItem(
                name: e.name,
                image: e.image,
                price: e.offerPrice,
                quantity: e.quantity))
            .toList(),
        shippingAddress: {
          "fullName": addresses[selectedAddress].fullName,
          "phoneNo": addresses[selectedAddress].phone,
          "pincode": addresses[selectedAddress].pincode,
          "city": addresses[selectedAddress].city,
          "state": addresses[selectedAddress].state,
          "doorNo": addresses[selectedAddress].address,
          "street": addresses[selectedAddress].address,
        },
        paymentMethod: "COD",
        taxAmount: taxAmount.toInt(),
        deliveryCharge: deliveryCharge,
        totalAmount:
            cartItemsAmount + taxAmount + deliveryCharge + packagingCharge,
        token: token,
      );
      clearCart();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => OrderResultScreen(),
        ),
      );
      setLoader(false);
    } catch (e) {
      print(e);
      setLoader(false);
    }
  }
}

class BottomContainer extends StatelessWidget {
  final List cartItems;
  final String buyFrom;
  final bool isFood;
  final int cartItemsAmount;
  final int taxAmount;
  final int packagingCharge;
  final int deliveryCharge;
  final int freeDeliveryMargin;
  final bool loader;
  final int selectedAddress;
  final Function setLoader;
  final Function clearCart;

  const BottomContainer({
    required this.cartItems,
    required this.buyFrom,
    required this.isFood,
    required this.cartItemsAmount,
    required this.taxAmount,
    required this.packagingCharge,
    required this.deliveryCharge,
    required this.freeDeliveryMargin,
    required this.loader,
    required this.selectedAddress,
    required this.setLoader,
    required this.clearCart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Consumer<Auth>(
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
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Rs. ${cartItemsAmount + packagingCharge + taxAmount + (cartItemsAmount > freeDeliveryMargin ? 0 : deliveryCharge)}"),
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
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 400,
                          child: ListView(
                            children: [],
                          ),
                        ),
                      ],
                    );
                  },
                )
                // () => submitForm(
                //   context: context,
                //   id: auth.userData["userId"],
                //   name: auth.userData["name"],
                //   isFood: isFood,
                //   orderItems: cartItems,
                //   cartItemsAmount: cartItemsAmount,
                //   taxAmount: taxAmount,
                //   packagingCharge: packagingCharge,
                //   deliveryCharge:
                //       cartItemsAmount > freeDeliveryMargin ? 0 : deliveryCharge,
                //   token: auth.authToken,
                //   buyFrom: buyFrom,
                //   selectedAddress: selectedAddress,
                //   clearCart: clearCart,
                //   setLoader: setLoader,
                // ),
                ,
                child:
                    //  loader
                    //     ? SizedBox(
                    //         width: 20,
                    //         height: 20,
                    //         child: CircularProgressIndicator(
                    //           color: Colors.black,
                    //           strokeWidth: 3,
                    //         ),
                    //       )
                    //     :
                    Row(
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
