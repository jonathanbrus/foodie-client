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
          margin: EdgeInsets.only(top: 18, left: 10, right: 10),
          child: Text(
            "Categories",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FoodieButton(),
        Container(
          width: double.infinity,
          height: 240,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.04,
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

class FoodieButton extends StatelessWidget {
  const FoodieButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.only(top: 22, bottom: 12, left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.of(context).pushNamed(FoodieHome.routeName),
            child: Container(
              width: double.infinity,
              height: 96,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
              child: Container(
                margin: EdgeInsets.only(left: 18, top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Food and Drinks",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Eat Good, Feel Good",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 14,
          bottom: 18,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(FoodieHome.routeName),
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/catImages/Res.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

const List categories = [
  {
    "title": "Groceries",
    "category": "groceries",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Gro.png",
  },
  {
    "title": "Meat",
    "category": "accessories",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Mea.png",
  },
  {
    "title": "Cosmetics",
    "category": "cosmetics",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Cos.png",
  },
  {
    "title": "Headphones",
    "category": "accessories",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Hea.png",
  },
  {
    "title": "Mobile cases",
    "category": "accessories",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Mob.png",
  },
  {
    "title": "Gifts",
    "category": "gifts",
    "routeName": ProductsScreen.routeName,
    "img": "assets/catImages/Gif.png",
  },
  // {
  //   "title": "HeadPhones",
  //   "category": "mobileAccessories",
  //   "routeName": ProductsScreen.routeName,
  //   "img": "assets/catImages/Mob.png",
  // },
  // {
  //   "title": "Mobile Cases",
  //   "category": "mobileAccessories",
  //   "routeName": ProductsScreen.routeName,
  //   "img": "assets/catImages/Mob.png",
  // },
  // {
  //   "title": "Offer Zone",
  //   "category": "cosmetics",
  //   "routeName": ProductsScreen.routeName,
  //   "img": "assets/catImages/Cos.png",
  // },
];
