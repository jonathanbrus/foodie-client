import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/food.dart';

class Foods with ChangeNotifier {
  List<Food> _foods = [];
  List<Map> _categories = [];
  bool _veg = false;
  List<String> _selections = [];
  String _search = "";

  List<String> categories(resId) {
    List<String> categories = ["Offer"];

    _categories.forEach((e) {
      if (e["resId"] == resId) {
        categories.add(e["category"]);
      }
    });

    return categories;
  }

  bool get veg {
    return _veg;
  }

  List<String> get selections {
    return [..._selections];
  }

  void setempty() {
    _foods = [];
  }

  List<Food> getAllFoods(String resId) {
    List<Food> foods = [
      ..._foods.where((food) => food.restaurantId == resId && food.veg == _veg)
    ];

    if (_search.length > 0 && _selections.length > 0) {
      return [
        ...foods.where(
          (food) =>
              food.name.toLowerCase().contains(
                    _search.toLowerCase(),
                  ) &&
              _selections.contains(food.category),
        )
      ];
    }

    if (_search.length > 0) {
      return [
        ...foods.where(
          (food) => food.name.toLowerCase().contains(
                _search.toLowerCase(),
              ),
        )
      ];
    }

    if (_selections.length > 0) {
      return [
        ...foods.where(
          (food) => _selections.contains(food.category),
        ),
      ];
    }

    return [...foods];
  }

  void toggleVeg(bool val) {
    _veg = val;
    notifyListeners();
  }

  void setSearch(search) {
    _search = search;

    notifyListeners();
  }

  void select(bool val, String selection) {
    if (val) {
      _selections.add(selection);
    } else {
      _selections.remove(selection);
    }

    notifyListeners();
  }

  void clearSelection() {
    _selections = [];
  }

  Future<void> fetchFoods(resId) async {
    if (_foods.where((e) => e.restaurantId == resId).isEmpty) {
      try {
        final url =
            Uri.parse("https://alofoodie.herokuapp.com/foods?id=$resId");
        final response = await http.get(url);

        List decoded = json.decode(response.body)["data"];

        List categoriesList = [];

        if (_foods.where((e) => e.restaurantId == resId).isEmpty) {
          _foods = [
            ..._foods,
            ...decoded.map((food) {
              categoriesList.add(food["category"]);

              return Food(
                id: food["_id"],
                name: food["name"],
                image: food["image"],
                description: food["description"],
                category: food["category"],
                veg: food["veg"],
                addons: food["addons"],
                toppings: food["toppings"],
                sizes: food["sizes"],
                buns: food["buns"],
                fixedPrice: food["fixedPrice"],
                offerPrice: food["offerPrice"],
                packingCharge: food["packingCharge"],
                availableFrom: food["timing"]["from"],
                availableTo: food["timing"]["to"],
                active: food["active"],
                bestSeller: food["bestSeller"],
                rating: 4.4,
                restaurantId: food["restaurantId"],
              );
            })
          ];
          _categories = [
            ..._categories,
            ...categoriesList
                .toSet()
                .map((category) => {"category": category, "resId": resId})
          ];
        }
      } catch (e) {
        print("food " + e.toString());
      }
      notifyListeners();
    }
  }
}
