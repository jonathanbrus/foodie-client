import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../foodie/providers/cart.dart';

import '../helpers/checkout_helper.dart';

import '../ui_widgets/delivery_detail.dart';

class PaymentsScreen extends StatefulWidget {
  static const routeName = "/payments";
  final int addressIndex;
  final bool food;

  const PaymentsScreen({
    required this.addressIndex,
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  bool _loader = false;
  int _index = 1;

  void setLoader() {
    setState(() {
      _loader = !_loader;
    });
  }

  void setIndex(value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Payments"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
              child: Text(
                "Delivering To",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            DeliveryDetail(index: widget.addressIndex),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
              child: Text(
                "Price Detail",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            PriceDetails(food: widget.food),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Payment Method",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.withOpacity(0.24),
              ),
              child: Column(
                children: [
                  RadioListTile<int?>(
                    title: Text("Cash On Delivery"),
                    value: 1,
                    groupValue: _index,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    onChanged: (int? value) {
                      setIndex(value);
                    },
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              CashLessPayNotice(),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(12),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    primary: Colors.black,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Okay"),
                                ),
                              ),
                            ],
                            clipBehavior: Clip.hardEdge,
                            contentPadding: EdgeInsets.only(top: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                    child: RadioListTile<int?>(
                      title: Text("Online Payments"),
                      value: 2,
                      groupValue: _index,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      onChanged: null,
                      //  (int? value) {
                      //   setIndex(value);
                      // },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: _loader
                    ? () {}
                    : () {
                        placeOrder(
                          addressIndex: widget.addressIndex,
                          context: context,
                          food: widget.food,
                          setLoader: setLoader,
                        );
                      },
                icon: Icon(
                  Icons.verified_rounded,
                  size: 18,
                ),
                label: _loader
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Place Order",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            CashLessPayNotice(),
          ],
        ),
      ),
    );
  }
}

class PriceDetails extends StatelessWidget {
  final bool food;
  const PriceDetails({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final foodieCart = Provider.of<FoodieCart>(context, listen: false);

    final noOfItems = food ? foodieCart.itemsCount : cart.getAllProducts.length;
    final packingCharge = food ? foodieCart.packagingCharge : 0;
    final deliveryCharge =
        food ? foodieCart.deliveryCharge : cart.deliveryCharge;
    final cartItemsAmount =
        food ? foodieCart.totalItemsAmount : cart.totalItemsAmount;
    final taxAmount = food ? foodieCart.taxAmount : cart.taxAmount;
    final freeDeliveryMargin = food ? 999 : 499;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.24),
      ),
      child: Column(
        children: [
          RowItem(
            title: "Price ($noOfItems items)",
            result: "Rs.$cartItemsAmount",
          ),
          RowItem(
            title: "Tax",
            result: "5%",
          ),
          if (food)
            RowItem(
              title: "Packaging Charge",
              result: packingCharge > 0 ? "Rs.$packingCharge" : "Free",
            ),
          RowItem(
            title: "Delivery Charge",
            result: cartItemsAmount > freeDeliveryMargin
                ? "Free"
                : "Rs.$deliveryCharge",
          ),
          Divider(color: Colors.black87),
          RowItem(
            title: "Total Amount",
            result:
                "Rs.${cartItemsAmount + taxAmount + packingCharge + (cartItemsAmount > freeDeliveryMargin ? 0 : deliveryCharge)}",
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
            maxLines: 3,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
