import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Food {
  final String id;
  final String name;
  final String image;
  final String description;
  final List addons;
  final List toppings;
  final List buns;
  final List sizes;
  final int offerPrice;
  final int fixedPrice;
  final int packagingCharge;
  final String category;
  final bool isActive;
  final int availableFrom;
  final int availableTo;
  final double rating;
  final bool bestSeller;
  final String restaurantId;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.addons,
    required this.toppings,
    required this.buns,
    required this.sizes,
    required this.offerPrice,
    required this.fixedPrice,
    required this.packagingCharge,
    required this.category,
    required this.isActive,
    required this.availableFrom,
    required this.availableTo,
    required this.rating,
    required this.bestSeller,
    required this.restaurantId,
  });
}

class Foods with ChangeNotifier {
  List<Food> _foods = [];
  List<Map> _categories = [];
  List<String> _selections = [];
  String _search = "";
  bool _shouldload = true;

  bool get shouldload {
    return _shouldload;
  }

  List<String> categories(resId) {
    List<String> categories = [];

    _categories.forEach((e) {
      if (e["resId"] == resId) {
        categories.add(e["category"]);
      }
    });

    return categories;
  }

  List<String> get selections {
    return [..._selections];
  }

  List<Food> getAllFoods(String resId) {
    List<Food> foods = [..._foods.where((food) => food.restaurantId == resId)];

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
    var prods = _foods.where((e) => e.restaurantId == resId).toList();

    if (prods.isEmpty) {
      _shouldload = true;
      try {
        final url = Uri.parse(
            "https://alofoodie-v2.herokuapp.com/getFoodItemsByResId?resId=$resId");
        final response = await http.get(url);

        List decoded = json.decode(response.body)["allFoods"];

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
              addons: [],
              toppings: [],
              buns: [],
              sizes: [],
              offerPrice: food["offerPrice"],
              fixedPrice: food["fixedPrice"],
              packagingCharge:
                  food["packagingCharge"] == null ? 0 : food["packagingCharge"],
              category: food["category"],
              isActive: food["isActive"],
              availableFrom: food["availabilityTiming"]["from"],
              availableTo: food["availabilityTiming"]["to"],
              rating: food["rating"] + 0.1,
              bestSeller: true,
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
