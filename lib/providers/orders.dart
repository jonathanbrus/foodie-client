import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  bool _noOrdersYet = false;

  bool _initialFetch = true;

  List<Order> get allOrders {
    return [..._orders];
  }

  Future<void> fetchAllOrders(String token, bool refresh) async {
    var url = Uri.parse("https://alofoodie.herokuapp.com/user/myOrders");

    if ((_initialFetch && !_noOrdersYet) || refresh) {
      try {
        final response = await http.get(url, headers: {
          HttpHeaders.authorizationHeader: '$token',
        });

        final decoded = json.decode(response.body);

        _orders = [
          ...(decoded["data"] as List<dynamic>).map((order) {
            return Order(
              id: order["_id"],
              food: order["food"] == null ? true : order["food"],
              orderItems: (order["orderItems"] as List<dynamic>)
                  .map(
                    (item) => OrderItem(
                      name: item["name"],
                      image: item["image"],
                      price: item["price"],
                      quantity: item["quantity"],
                      addon: item["addon"],
                      topping: item["topping"],
                      size: item["size"],
                      bun: item["bun"],
                    ),
                  )
                  .toList(),
              buyFrom:
                  order["buyFrom"] == null ? "AloFoodie" : order["buyFrom"],
              shippingAddress: order["shippingAddress"],
              paymentMethod: order["paymentMethod"],
              taxAmount: order["taxAmount"] == null
                  ? order["taxPrice"]
                  : order["taxAmount"],
              deliveryCharge: order["deliveryCharge"] == null
                  ? order["deliveryPrice"]
                  : order["deliveryCharge"],
              totalAmount: order["totalAmount"] == null
                  ? order["totalPrice"]
                  : order["totalAmount"],
              paid: order["paid"],
              orderStatus: order["orderStatus"],
              createdAt: DateTime.parse(order["createdAt"]),
            );
          }).toList()
        ];
        _initialFetch = false;
        _noOrdersYet = decoded["data"].isEmpty;

        notifyListeners();
      } catch (e) {
        print("from orders $e");
      }
    }
  }

  Future<void> placeOrder(
      {required bool food,
      required String buyFrom,
      required List<OrderItem> orderItems,
      required Map shippingAddress,
      required String paymentMethod,
      required int taxAmount,
      required int deliveryCharge,
      required int packingCharge,
      required int totalAmount,
      required String token}) async {
    var url = Uri.parse("https://alofoodie.herokuapp.com/user/placeOrder");

    try {
      final response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: token
      }, body: {
        "food": "$food",
        "buyFrom": buyFrom.toString(),
        "orderItems": json.encode(orderItems),
        "shippingAddress": json.encode(shippingAddress),
        "paymentMethod": paymentMethod.toString(),
        "taxAmount": taxAmount.toString(),
        "deliveryCharge": deliveryCharge.toString(),
        "packingCharge": packingCharge.toString(),
        "totalAmount": totalAmount.toString(),
      });

      final decodedNewOrder = json.decode(response.body);

      _orders.insert(
        0,
        Order(
          id: decodedNewOrder["data"]["_id"],
          food: food,
          buyFrom: decodedNewOrder["data"]["buyFrom"],
          orderItems: orderItems,
          shippingAddress: shippingAddress,
          paymentMethod: paymentMethod,
          taxAmount: taxAmount,
          deliveryCharge: deliveryCharge,
          totalAmount: totalAmount,
          paid: decodedNewOrder["data"]["paid"],
          orderStatus: decodedNewOrder["data"]["orderStatus"],
          createdAt: DateTime.parse(decodedNewOrder["data"]["createdAt"]),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelOrder(String orderId, String token) async {
    var url = Uri.parse("https://alofoodie.herokuapp.com/user/cancelOrder");

    try {
      await http.delete(url,
          headers: {HttpHeaders.authorizationHeader: token},
          body: {"orderId": orderId});

      _orders = _orders.map((order) {
        if (order.id == orderId) {
          order.orderStatus = "Canceled";
        }
        return order;
      }).toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
