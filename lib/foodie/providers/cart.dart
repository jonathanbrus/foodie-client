import 'package:flutter/material.dart';

class FoodieCartItem {
  final String id;
  final String name;
  final String image;
  final int fixedPrice;
  final int offerPrice;
  final int packagingCharge;
  int quantity;

  FoodieCartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.fixedPrice,
    required this.offerPrice,
    required this.packagingCharge,
    required this.quantity,
  });
}

class FoodieCart with ChangeNotifier {
  Map<String, FoodieCartItem> _cart = {};

  List<FoodieCartItem> get cartItems {
    return [..._cart.values];
  }

  int get itemsAmount {
    int amount = 0;
    _cart
        .forEach((key, value) => amount += (value.offerPrice * value.quantity));

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

  int get itemsCount {
    int items = 0;
    _cart.forEach((key, value) => items += value.quantity);

    return items.toInt();
  }

  int quantity(String id) {
    return _cart.containsKey(id) ? _cart[id]!.quantity : 0;
  }

  void addItem(
    String id,
    String name,
    String image,
    int fixedPrice,
    int offerPrice,
    int packagingCharge,
  ) {
    FoodieCartItem newItem = FoodieCartItem(
      id: id,
      name: name,
      image: image,
      quantity: 1,
      fixedPrice: fixedPrice,
      offerPrice: offerPrice,
      packagingCharge: packagingCharge,
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

  void removeItem(String id) {
    if (_cart.containsKey(id)) {
      if (_cart[id]!.quantity > 1) {
        _cart.update(
          id,
          (value) => FoodieCartItem(
            id: id,
            name: value.name,
            image: value.image,
            quantity: value.quantity - 1,
            fixedPrice: value.offerPrice,
            offerPrice: value.offerPrice,
            packagingCharge: value.packagingCharge,
          ),
        );
      } else {
        _cart.remove(id);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
  }
}
