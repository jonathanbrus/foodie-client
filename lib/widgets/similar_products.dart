import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../ui_widgets/product_item.dart';

class SimilarProducts extends StatelessWidget {
  final String category;
  const SimilarProducts({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "Similar Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Consumer<Products>(builder: (context, prods, ch) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: prods.getRandomBySubCategory(category).map(
                  (product) {
                    return Container(
                      width: 160,
                      height: 220,
                      margin: EdgeInsets.all(4),
                      child: ProductGridItem(productDetail: product),
                    );
                  },
                ).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
