import 'package:flutter/material.dart';

//screens
import '../../foodie/screens/foodie_home.dart';
import '../screens/products.dart';

import '../ui_widgets/category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Text(
            "Categories",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: (categories.length / 4).ceil() * 106,
          margin: EdgeInsets.only(bottom: 5),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.86,
            ),
            physics: NeverScrollableScrollPhysics(),
            children: [
              ...categories.map(
                (category) => CategoryItem(
                  title: category["title"],
                  category: category["category"],
                  routeName: category["routeName"],
                  img: category["img"],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const List categories = [
  {
    "title": "Food & Drinks",
    "category": "Foods",
    "routeName": FoodieHome.routeName,
    "img": "assets/catImages/Res.png",
  },
  {
    "title": "Groceries",
    "category": "groceries",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Gro.png",
  },
  {
    "title": "Toys",
    "category": "kidsSection",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Kid.png",
  },
  {
    "title": "Gifts",
    "category": "gifts",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Gif.png",
  },
  {
    "title": "Gadgets",
    "category": "mobileAccessories",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Mob.png",
  },
  {
    "title": "Accessories",
    "category": "accessories",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Ace.png",
  },
  {
    "title": "Cosmetics",
    "category": "cosmetics",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Cos.png",
  },
  {
    "title": "Clothing",
    "category": "clothing",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Clo.png",
  }
];
