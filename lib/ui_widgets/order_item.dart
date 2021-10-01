import 'package:flutter/material.dart';

import '../models/order.dart';

import '../screens/order_details.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 6, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          OrderDetailsScreen.routeName,
          arguments: [widget.order.id],
        ),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#" + widget.order.id.substring(0, 9),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Ordered at " + widget.order.buyFrom,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Status", style: TextStyle(fontSize: 14)),
                  Text(
                    "${widget.order.orderStatus}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number Of Items", style: TextStyle(fontSize: 14)),
                  Text("${widget.order.orderItems.length}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount", style: TextStyle(fontSize: 14)),
                  Text(
                    "Rs.${widget.order.totalAmount}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
