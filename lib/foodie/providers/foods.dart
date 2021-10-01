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
        print("fetching");
        final url = Uri.parse(
            "https://alofoodie-1.herokuapp.com/allFoodsByRes?resId=$resId");
        final response = await http.get(url);

        List decoded = json.decode(response.body)["foods"];

        List categoriesList = [];

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
              addons: food["addons"].length == 0 ? null : food["addons"],
              toppings: food["toppings"].length == 0 ? null : food["toppings"],
              sizes: food["sizes"].length == 0 ? null : food["sizes"],
              buns: food["buns"].length == 0 ? null : food["buns"],
              fixedPrice: food["fixedPrice"],
              offerPrice: food["offerPrice"],
              packagingCharge:
                  food["packagingCharge"] == null ? 0 : food["packagingCharge"],
              availableFrom: food["availabilityTiming"]["from"],
              availableTo: food["availabilityTiming"]["to"],
              isActive: food["isActive"],
              bestSeller:
                  food["bestSeller"] == null ? false : food["bestSeller"],
              rating: 4.4,
              // food["rating"] + 0.1,
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
      } catch (e) {
        print("food " + e.toString());
      }
      notifyListeners();
    }
  }
}
