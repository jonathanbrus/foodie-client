import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String name;
  final String image;
  final int price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
      };
}

class Order {
  final String id;
  final bool isFood;
  final String buyFrom;
  final List<OrderItem> orderItems;
  final Map shippingAddress;
  final String paymentMethod;
  final int taxAmount;
  final int deliveryCharge;
  final int totalAmount;
  String orderStatus;
  final bool isPaid;
  final DateTime createdAt;
  // final DateTime deliveredAt;

  Order({
    required this.id,
    required this.isFood,
    required this.buyFrom,
    required this.orderItems,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.isPaid,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.orderStatus,
    required this.createdAt,
    // required this.deliveredAt
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  bool _noOrdersYet = false;

  bool _initialFetch = true;

  List<Order> get allOrders {
    return [..._orders];
  }

  Future<void> fetchAllOrders(String token) async {
    var url = Uri.parse("https://alofoodie-v2.herokuapp.com/user/myOrders");

    if (_initialFetch && !_noOrdersYet) {
      try {
        final response = await http.get(url, headers: {
          HttpHeaders.authorizationHeader: '$token',
        });

        final decoded = json.decode(response.body);

        _orders = [
          ...(decoded["myOrders"] as List<dynamic>).map((order) {
            return Order(
              id: order["_id"],
              isFood: order["isFood"],
              orderItems: (order["orderItems"] as List<dynamic>)
                  .map(
                    (item) => OrderItem(
                      name: item["name"],
                      image: item["image"],
                      price: item["price"],
                      quantity: item["quantity"],
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
              isPaid: order["isPaid"],
              orderStatus: order["orderStatus"],
              createdAt: DateTime.parse(order["createdAt"]),
            );
          }).toList()
        ];
        _initialFetch = false;
        _noOrdersYet = decoded["myOrders"].isEmpty;

        notifyListeners();
      } catch (e) {
        print("from orders $e");
      }
    }
  }

  Future<void> placeOrder(
      {required String userId,
      required bool isFood,
      required String buyFrom,
      required List<OrderItem> orderItems,
      required Map shippingAddress,
      required String paymentMethod,
      required int taxAmount,
      required int deliveryCharge,
      required int totalAmount,
      required String token}) async {
    var url = Uri.parse("https://alofoodie-v2.herokuapp.com/user/placeOrder");

    try {
      final response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: token
      }, body: {
        "userId": userId.toString(),
        "isFood": isFood.toString(),
        "buyFrom": buyFrom.toString(),
        "orderItems": json.encode(orderItems),
        "shippingAddress": json.encode(shippingAddress),
        "paymentMethod": paymentMethod.toString(),
        "taxAmount": taxAmount.toString(),
        "deliveryCharge": deliveryCharge.toString(),
        "totalAmount": totalAmount.toString(),
      });

      final decodedNewOrder = json.decode(response.body);

      _orders.insert(
        0,
        Order(
          id: decodedNewOrder["newOrder"]["_id"],
          isFood: isFood,
          buyFrom: decodedNewOrder["newOrder"]["buyFrom"],
          orderItems: orderItems,
          shippingAddress: shippingAddress,
          paymentMethod: paymentMethod,
          taxAmount: taxAmount,
          deliveryCharge: deliveryCharge,
          totalAmount: totalAmount,
          isPaid: decodedNewOrder["newOrder"]["isPaid"],
          orderStatus: decodedNewOrder["newOrder"]["orderStatus"],
          createdAt: DateTime.parse(decodedNewOrder["newOrder"]["createdAt"]),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelOrder(String orderId, String token) async {
    var url = Uri.parse("https://alofoodie-v2.herokuapp.com/user/cancelOrder");

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
      notifyListeners();
    }
    notifyListeners();
  }
}
