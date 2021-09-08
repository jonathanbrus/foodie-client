import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/user.dart';

import '../helpers/steps.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = "/order-details";
  final String orderId;
  const OrderDetailsScreen({required this.orderId, Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailsScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final orderProvier = Provider.of<Orders>(context);

    final order = orderProvier.allOrders
        .firstWhere((order) => order.id == widget.orderId);

    late List<Step> steps;

    switch (order.orderStatus.toLowerCase()) {
      case "canceled":
        steps = canceledSteps;
        break;

      case "confirmed":
        steps = confirmedSteps;
        break;

      case "packed":
        steps = packedSteps;
        break;

      case "delivery":
        steps = deliverySteps;
        break;

      case "delivered":
        steps = deliveredSteps;
        break;

      default:
        steps = requestedSteps;
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Order Details"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 4),
              child: Text(
                "#" + order.id.substring(0, 9),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 4),
              child: Text(
                "Ordered at " + order.buyFrom,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Stepper(
              controlsBuilder: (context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Container();
              },
              onStepTapped: (int i) {
                setState(() {
                  _index = i;
                });
              },
              currentStep: _index,
              physics: NeverScrollableScrollPhysics(),
              steps: steps,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 8),
              child: Text(
                "Products",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...order.orderItems.map(
              (item) => Container(
                margin: EdgeInsets.only(bottom: 6, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.4),
                    width: 1.6,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Quantity ${item.quantity}"),
                          Text("\u{20B9}${item.price}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 0),
              child: Text(
                "Shipping Detail",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name"),
                      Text(
                        order.shippingAddress["fullName"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phone"),
                      Text(
                        order.shippingAddress["phone"].toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Address"),
                      Text(
                        order.shippingAddress["address"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("State"),
                      Text(
                        order.shippingAddress["state"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
              child: Text(
                "Payment Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payable amount"),
                      Text(
                        "\u{20B9}${order.totalAmount}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Method"),
                      Text(
                        order.paymentMethod,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment status"),
                      Text(
                        order.orderStatus == "Canceled"
                            ? "Canceled"
                            : order.isPaid
                                ? "Paid"
                                : "Payment Pending",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.redo_rounded),
                label: Text("Order Again"),
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            if (!order.isFood)
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
                child: TextButton.icon(
                  onPressed: order.orderStatus.toLowerCase() == "order placed"
                      ? () => cancelOrder(
                          context, orderProvier.cancelOrder, order.id)
                      : () {},
                  icon: Icon(Icons.cancel_rounded),
                  label: Text("Cancel Order"),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> cancelOrder(
    BuildContext context, Function cancelOrder, String orderId) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        child: Text("Are you sure you want to cancel this order?"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<User>(
          builder: (ctx, auth, ch) => TextButton(
            onPressed: () {
              cancelOrder(orderId, auth.authToken);
              Navigator.of(context).pop();
            },
            child: Text("Yes"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
