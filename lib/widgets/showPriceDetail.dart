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
      height: MediaQuery.of(context).size.height * 0.26,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Price Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.only(top: 6, left: 6, right: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.24),
            ),
            child: Column(
              children: [
                RowItem(
                  title: "Price ($noOfItems items)",
                  result: "Rs.$itemsAmount",
                ),
                RowItem(
                  title: "Tax",
                  result: "5%",
                ),
                if (from != "AloFoodie")
                  RowItem(
                    title: "Packaging Charge",
                    result:
                        packagingCharge > 0 ? "Rs.$packagingCharge" : "Free",
                  ),
                RowItem(
                  title: "Delivery Charge",
                  result: itemsAmount > freeDeliveryMargin
                      ? "Free"
                      : "Rs.$deliveryCharge",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RowItem(
              title: "Total Amount",
              result:
                  "Rs.${itemsAmount + taxAmount + packagingCharge + (itemsAmount > freeDeliveryMargin ? 0 : deliveryCharge)}",
            ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
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
      ),
    );
  }
}

void showPriceDetail({
  required BuildContext context,
  required String from,
  required int noOfItems,
  required int itemsAmount,
  required int taxAmount,
  required int packagingCharge,
  required int deliveryCharge,
  required int freeDeliveryMargin,
}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => PriceDetail(
        from: from,
        noOfItems: noOfItems,
        itemsAmount: itemsAmount,
        taxAmount: taxAmount,
        packagingCharge: packagingCharge,
        deliveryCharge: deliveryCharge,
        freeDeliveryMargin: 999,
      ),
    );
