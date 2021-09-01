import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/orders.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;

  void toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  get statusColor {
    switch (widget.order.orderStatus.toLowerCase()) {
      case "order placed":
        return Colors.amber[600];
      case "packed":
        return Colors.green;
      case "delivered":
        return Colors.green[800];
      case "canceled":
        return Colors.red;
      default:
        return Colors.amber[600];
    }
  }

  Future<void> cancelOrder(
      BuildContext context, Function cancelOrder, String orderId) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Cancel Order?"),
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
            ),
          ),
          Consumer<Auth>(
            builder: (ctx, auth, ch) => TextButton(
              onPressed: () {
                cancelOrder(orderId, auth.authToken);
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.order.buyFrom.length > 10
                      ? "${widget.order.buyFrom.substring(0, 9)}..."
                      : widget.order.buyFrom,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: statusColor,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Text(
                    widget.order.orderStatus,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Order Items",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: toggle,
                    child: Icon(_expanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ),
                ),
              ],
            ),
            ...widget.order.orderItems.map(
              (item) => AnimatedContainer(
                duration: Duration(milliseconds: 180),
                height: _expanded ? 22 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item.name.length > 30
                          ? item.name.substring(0, 29)
                          : item.name,
                      style: TextStyle(fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      "Quantity: ${item.quantity}",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 26),
                    Text(
                      "Rs.${item.price}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("Rs.${widget.order.totalAmount}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            if (!widget.order.isFood)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Consumer<Orders>(
                    builder: (ctx, orders, ch) =>
                        widget.order.orderStatus.toLowerCase() == "order placed"
                            ? InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => cancelOrder(context,
                                    orders.cancelOrder, widget.order.id),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    "Cancel Order",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
