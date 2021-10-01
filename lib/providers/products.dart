import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _otherProducts = [];
  List<Map> _categories = [];
  List<String> _selections = [];
  String _search = "";
  bool _shouldload = true;

  bool get shouldload {
    return _shouldload;
  }

  List<String> categories(category) {
    List<String> categories = [];

    _categories.forEach((e) {
      if (e["category"] == category) {
        categories.add(e["subCategory"]);
      }
    });

    return categories;
  }

  List<String> get selections {
    return [..._selections];
  }

  List<Product> getRandomBySubCategory(String category) {
    List products = _otherProducts
        .where((product) => product.subCategory == category)
        .toList();

    products.shuffle();

    var n = products.length > 5 ? 5 : products.length;

    return [...products.sublist(0, n)];
  }

  List<Product> getAllProductsByCategory(String category) {
    final List products = [
      ..._otherProducts.where((element) => element.category == category)
    ];

    if (_search.length > 0 && _selections.length > 0) {
      return [
        ...products.where(
          (product) =>
              _selections.contains(product.subCategory.trim()) &&
              product.name.toLowerCase().contains(
                    _search.toLowerCase(),
                  ),
        ),
      ];
    }

    if (_search.length > 0) {
      return [
        ...products.where(
          (product) => product.name.toLowerCase().contains(
                _search.toLowerCase(),
              ),
        )
      ];
    }

    if (_selections.length > 0) {
      return [
        ...products.where(
          (product) => _selections.contains(product.subCategory.trim()),
        ),
      ];
    }

    return [...products];
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

  void setSearch(search) {
    _search = search;

    notifyListeners();
  }

  Future<void> fetchProducts(String category) async {
    var prods = _otherProducts.where((e) => e.category == category).toList();

    if (prods.isEmpty) {
      _shouldload = true;
      try {
        final url = Uri.parse(
            "https://alofoodie-1.herokuapp.com/allProductsByCategory?category=$category");
        final response = await http.get(url);

        List decoded = json.decode(response.body)["products"];

        List categoriesList = [];

        _otherProducts = [
          ..._otherProducts,
          ...decoded.map((product) {
            categoriesList.add(product["subCategory"]);

            return Product(
              id: product["_id"],
              name: product["name"],
              image: product["image"],
              description: product["description"],
              productDetail: product["productDetail"],
              offerPrice: product["offerPrice"],
              fixedPrice: product["fixedPrice"],
              deliveryCharge: product["deliveryCharge"],
              itemsInStock: product["itemsInStock"],
              category: product["category"],
              subCategory: product["subCategory"],
              sizes: [],
              colors: [],
              rating: 4.1,
              // product["rating"] + 0.1,
              bestSeller: true,
            );
          })
        ];

        _categories = [
          ..._categories,
          ...categoriesList
              .map((e) => e.trim())
              .toSet()
              .map((cat) => {"subCategory": cat, "category": category})
        ];

        _shouldload = false;
      } catch (e) {
        print(e.toString());
      }
      notifyListeners();
    }
  }
}
