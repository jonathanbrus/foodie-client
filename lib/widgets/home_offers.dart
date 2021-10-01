import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/products.dart';

class HomeOfferButtons extends StatefulWidget {
  const HomeOfferButtons({Key? key}) : super(key: key);

  @override
  _HomeOfferButtonsState createState() => _HomeOfferButtonsState();
}

class _HomeOfferButtonsState extends State<HomeOfferButtons> {
  List _images = [];
  List categories = [
    {
      "title": "Offer Zone 1",
      "category": "offer1",
    },
    {
      "title": "Offer Zone 2",
      "category": "offer2",
    },
  ];

  fetchSlider() async {
    var url = Uri.parse(
        "https://alofoodie-1.herokuapp.com/fetchImages?imageFor=homeoffer");
    try {
      final response = await http.get(url);

      final decoded = json.decode(response.body);

      setState(() {
        _images = [decoded["images"][0], decoded["images"][1]];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _images.map((image) {
          final category = categories[_images.indexOf(image)];

          return Card(
            elevation: 5,
            margin: EdgeInsets.only(top: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => Navigator.of(context).pushNamed(
                  ProductsScreen.routeName,
                  arguments: [
                    category["title"],
                    category["category"],
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
