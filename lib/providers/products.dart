import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String name;
  final List image;
  final String description;
  final List productDetail;
  final int offerPrice;
  final int fixedPrice;
  final int deliveryCharge;
  final int itemsInStock;
  final String category;
  final String subCategory;
  final List sizes;
  final String sizeChart;
  final List colors;
  final double rating;
  final bool bestSeller;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.productDetail,
    required this.offerPrice,
    required this.fixedPrice,
    required this.deliveryCharge,
    required this.itemsInStock,
    required this.category,
    required this.subCategory,
    required this.sizes,
    required this.sizeChart,
    required this.colors,
    required this.rating,
    required this.bestSeller,
  });
}

class Products with ChangeNotifier {
  List<Product> _otherProducts = [];
  List<Map> _categories = [];
  List<String> _selections = ["All"];
  bool _shouldload = true;

  bool get shouldload {
    return _shouldload;
  }

  List<String> categories(category) {
    List<String> categories = ["All"];

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

    if (_selections.length > 0) {
      if (_selections.length == 1 && _selections[0] == "All") {
        return [...products];
      }

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
    _selections = ["All"];
  }

  Future<void> fetchProducts(String category) async {
    var prods = _otherProducts.where((e) => e.category == category).toList();

    if (prods.isEmpty) {
      _shouldload = true;
      try {
        final url = Uri.parse(
            "https://alofoodie-v2.herokuapp.com/getAllProductsByCategory?category=$category");
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
              sizeChart: "",
              colors: [],
              rating: product["rating"] + 0.1,
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
