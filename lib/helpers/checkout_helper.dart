import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
// import '../providers/orders.dart';

import '../widgets/AddressSelection.dart';
import '../widgets/showPriceDetail.dart';

List restricted = ["KFC", "Domino's", "Dindigul Thalappakatti"];

// void submitForm({
//   required BuildContext context,
//   required String id,
//   required String name,
//   required bool isFood,
//   required List orderItems,
//   required int cartItemsAmount,
//   required int taxAmount,
//   required int packagingCharge,
//   required int deliveryCharge,
//   required String token,
//   required String buyFrom,
//   // required int selectedAddress,
//   required Function clearCart,
//   required Function setLoader,
// }) async {
//   final addresses = Provider.of<User>(context, listen: false).addresses;

//   if (addresses.length <= 0) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Add address to place orders."),
//       ),
//     );
//   } else if (restricted.contains(buyFrom) &&
//       (DateTime.now().hour >= 21 || DateTime.now().hour <= 9)) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text("Cannot deliver orders now."),
//         action: SnackBarAction(
//           textColor: Colors.white,
//           label: "Okay",
//           onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   } else {
//     setLoader(true);
//     try {
//       await Provider.of<Orders>(context, listen: false).placeOrder(
//         userId: id,
//         isFood: isFood,
//         buyFrom: buyFrom,
//         orderItems: orderItems
//             .map((e) => OrderItem(
//                 name: e.name,
//                 image: e.image,
//                 price: e.offerPrice,
//                 quantity: e.quantity))
//             .toList(),
//         shippingAddress: {
//           // "fullName": addresses[selectedAddress].fullName,
//           // "phone": addresses[selectedAddress].phone,
//           // "pincode": addresses[selectedAddress].pincode,
//           // "address": addresses[selectedAddress].address,
//           // "city": addresses[selectedAddress].city,
//           // "state": addresses[selectedAddress].state,
//         },
//         paymentMethod: "COD",
//         taxAmount: taxAmount.toInt(),
//         deliveryCharge: deliveryCharge,
//         totalAmount:
//             cartItemsAmount + taxAmount + deliveryCharge + packagingCharge,
//         token: token,
//       );
//       clearCart();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (_) => OrderResultScreen(),
//         ),
//       );
//       setLoader(false);
//     } catch (e) {
//       print(e);
//       setLoader(false);
//     }
//   }
// }

class BottomContainer extends StatefulWidget {
  final List cartItems;
  final String buyFrom;
  final bool isFood;
  final int cartItemsAmount;
  final int taxAmount;
  final int packagingCharge;
  final int deliveryCharge;
  final int freeDeliveryMargin;
  final Function clearCart;

  BottomContainer({
    required this.cartItems,
    required this.buyFrom,
    required this.isFood,
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
  int? _index = 0;

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
                        from: widget.buyFrom,
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
                onPressed: () => showAddressSelection(context, _index),
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
          )
        ],
      ),
    );
  }
}
