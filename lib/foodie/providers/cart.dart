import 'package:flutter/material.dart';

import '../../models/cart_item.dart';

class FoodieCart with ChangeNotifier {
  String _restaurantName = "";
  int _deliveryCharge = 0;
  Map<String, CartItem> _cart = {};

  List<CartItem> get cartItems {
    return [..._cart.values];
  }

  String get restaurantName {
    return _restaurantName;
  }

  int get totalItemsAmount {
    int amount = 0;
    _cart.forEach(
      (key, value) => amount += ((value.offerPrice * value.quantity)) +
          value.addonPrice +
          value.toppingPrice +
          value.sizePrice +
          value.bunPrice,
    );

    return amount.toInt();
  }

  int get taxAmount {
    int amount = 0;
    _cart
        .forEach((key, value) => amount += (value.offerPrice * value.quantity));

    return ((amount / 100) * 5).ceil();
  }

  int get packagingCharge {
    int amount = 0;
    _cart.forEach(
        (key, value) => amount += (value.packagingCharge * value.quantity));

    return amount.toInt();
  }

  int get deliveryCharge {
    return _deliveryCharge;
  }

  int get itemsCount {
    int items = 0;
    _cart.forEach((key, value) => items += value.quantity);

    return items.toInt();
  }

  int quantity(String id) {
    return _cart.containsKey(id) ? _cart[id]!.quantity : 0;
  }

  Map<String, dynamic>? addon(String id) {
    return (_cart.containsKey(id) &&
            _cart[id]!.addon != null &&
            _cart[id]!.addon != "none" &&
            _cart[id]!.addon != "None")
        ? {"name": "${_cart[id]!.addon}", "price": _cart[id]!.addonPrice}
        : null;
  }

  Map<String, dynamic>? topping(String id) {
    return (_cart.containsKey(id) &&
            _cart[id]!.topping != null &&
            _cart[id]!.topping != "none" &&
            _cart[id]!.topping != "None")
        ? {"name": "${_cart[id]!.topping}", "price": _cart[id]!.toppingPrice}
        : null;
  }

  Map<String, dynamic>? size(String id) {
    return (_cart.containsKey(id) &&
            _cart[id]!.size != null &&
            _cart[id]!.size != "none" &&
            _cart[id]!.size != "None")
        ? {"name": "${_cart[id]!.size}", "price": _cart[id]!.sizePrice}
        : null;
  }

  Map<String, dynamic>? bun(String id) {
    return (_cart.containsKey(id) &&
            _cart[id]!.bun != null &&
            _cart[id]!.bun != "none" &&
            _cart[id]!.bun != "None")
        ? {"name": "${_cart[id]!.bun}", "price": _cart[id]!.bunPrice}
        : null;
  }

  bool inCart(String id) {
    return _cart.containsKey(id);
  }

  void setRestaurantAndDeliveryCharge({
    required String restaurantName,
    required int deliveryCharge,
  }) {
    _restaurantName = restaurantName;
    _deliveryCharge = deliveryCharge;
  }

  void addItem(
    String id,
    String name,
    String image,
    int fixedPrice,
    int offerPrice,
    int packagingCharge,
  ) {
    CartItem newItem = CartItem(
      id: id,
      name: name,
      image: image,
      quantity: 1,
      fixedPrice: fixedPrice,
      offerPrice: offerPrice,
      packagingCharge: packagingCharge,
      deliveryCharge: 0,
      addonPrice: 0,
      toppingPrice: 0,
      sizePrice: 0,
      bunPrice: 0,
    );

    if (_cart.containsKey(id)) {
      _cart.forEach((key, value) {
        if (key == id && value.quantity < 9) {
          value.quantity++;
        }
      });
    } else {
      _cart.addAll({id: newItem});
    }
    notifyListeners();
  }

  void selectAddon(String id, String addon, int price) {
    if (!_cart.containsKey(id)) return;
    _cart.forEach((key, value) {
      if (key == id) {
        value.addon = addon;
        value.addonPrice = price;
      }
    });
    notifyListeners();
  }

  void selectTopping(String id, String topping, int price) {
    if (!_cart.containsKey(id)) return;
    _cart.forEach((key, value) {
      if (key == id) {
        value.topping = topping;
        value.toppingPrice = price;
      }
    });
    notifyListeners();
  }

  void selectSize(String id, String size, int price) {
    if (!_cart.containsKey(id)) return;
    _cart.forEach((key, value) {
      if (key == id) {
        value.size = size;
        value.sizePrice = price;
      }
    });
    notifyListeners();
  }

  void selectBun(String id, String bun, int price) {
    if (!_cart.containsKey(id)) return;
    _cart.forEach((key, value) {
      if (key == id) {
        value.bun = bun;
        value.bunPrice = price;
      }
    });
    notifyListeners();
  }

  void removeItem(String id) {
    if (_cart.containsKey(id)) {
      if (_cart[id]!.quantity > 1) {
        _cart.forEach((key, value) {
          if (key == id) {
            value.quantity--;
          }
        });
      } else {
        _cart.remove(id);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
