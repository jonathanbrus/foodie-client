import 'package:flutter/material.dart';

class PriceDetail extends StatelessWidget {
  final String from;
  final int noOfItems;
  final int itemsAmount;
  final int taxAmount;
  final int packagingCharge;
  final int deliveryCharge;
  final int freeDeliveryMargin;
  const PriceDetail(
      {required this.from,
      required this.noOfItems,
      required this.itemsAmount,
      required this.taxAmount,
      required this.packagingCharge,
      required this.deliveryCharge,
      required this.freeDeliveryMargin,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3),
          Text(
            "PRICE DETAILS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Divider(height: 1, color: Colors.grey),
          SizedBox(height: 5),
          RowItem(
            title: "Price ($noOfItems items)",
            result: "Rs. $itemsAmount",
          ),
          RowItem(
            title: "Tax",
            result: "Rs. $taxAmount",
          ),
          if (from == "Food")
            RowItem(
              title: "Packaging Charge",
              result: packagingCharge > 0 ? "Rs.$packagingCharge" : "Free",
            ),
          RowItem(
            title: "Delivery Charge",
            result:
                itemsAmount > freeDeliveryMargin ? "Free" : "$deliveryCharge",
          ),
          SizedBox(height: 5),
          Divider(height: 1, color: Colors.grey),
          SizedBox(height: 5),
          RowItem(
            title: "Total Amount",
            result:
                "Rs. ${itemsAmount + taxAmount + packagingCharge + (itemsAmount > freeDeliveryMargin ? 0 : deliveryCharge)}",
          ),
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String title;
  final String result;

  const RowItem({
    Key? key,
    required this.title,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          result,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
