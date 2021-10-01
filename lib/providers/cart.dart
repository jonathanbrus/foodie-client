import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  List _cart = [];

  bool _intialLoad = true;

  int get totalItemsAmount {
    int amount = 0;
    _cart.forEach((item) {
      amount = (amount + (item.offerPrice * item.quantity)).toInt();
    });
    return amount;
  }

  int get taxAmount {
    int amount = 0;
    _cart.forEach((item) {
      amount = (amount + (item.offerPrice * item.quantity)).toInt();
    });
    return ((amount / 100) * 5).ceil();
  }

  int get deliveryCharge {
    return _cart.isEmpty ? 0 : 30;
  }

  List<CartItem> get getAllProducts {
    return [..._cart];
  }

  Future<void> myCart(String token) async {
    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/myCart");

    if (_intialLoad) {
      try {
        final response = await http.get(url, headers: {
          HttpHeaders.authorizationHeader: '$token',
        });

        final decoded = json.decode(response.body);

        _cart = decoded["myCartItems"]
            .map(
              (item) => CartItem(
                id: item["id"],
                name: item["name"],
                image: item["image"],
                fixedPrice: item["fixedPrice"],
                offerPrice: item["offerPrice"],
                quantity: item["quantity"],
                packagingCharge: 0,
                deliveryCharge: 40,
                addonPrice: 0,
                bunPrice: 0,
                sizePrice: 0,
                toppingPrice: 0,
              ),
            )
            .toList();
      } catch (e) {
        print(e);
      }

      _intialLoad = false;

      notifyListeners();
    }
  }

  Future<void> addToCart({
    required String id,
    required String image,
    required String name,
    required int offerPrice,
    required int fixedPrice,
    required int deliveryCharge,
    required String token,
  }) async {
    CartItem newItem = CartItem(
      id: id,
      image: image,
      name: name,
      fixedPrice: fixedPrice,
      offerPrice: offerPrice,
      packagingCharge: 0,
      deliveryCharge: deliveryCharge,
      addonPrice: 0,
      bunPrice: 0,
      sizePrice: 0,
      toppingPrice: 0,
      quantity: 1,
    );

    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/addToCart");

    try {
      if (_cart.where((element) => element.id == id).isEmpty) {
        await http.post(url, headers: {
          HttpHeaders.authorizationHeader: '$token',
        }, body: {
          "productId": id,
          "quantity": "${1}",
        });

        _cart.insert(0, newItem);
      }
    } catch (e) {
      print(e);
    }

    // notifyListeners();
  }

  Future<void> removeFromCart(String id, String token) async {
    var url =
        Uri.parse("https://alofoodie-1.herokuapp.com/user/removeFromCart");

    try {
      await http.delete(url, headers: {
        HttpHeaders.authorizationHeader: '$token',
      }, body: {
        "id": id
      });

      _cart.removeWhere((item) => item.id == id);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> modifyQuantity(String id, int quantity, String token) async {
    var url =
        Uri.parse("https://alofoodie-1.herokuapp.com/user/modifyQuantity");

    try {
      await http.post(url, headers: {
        HttpHeaders.authorizationHeader: '$token',
      }, body: {
        "productId": id,
        "quantity": "$quantity",
      });

      _cart.forEach((item) {
        if (item.id == id) {
          item.quantity = quantity;
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearCart() async {
    _cart = [];
    notifyListeners();
  }
}
