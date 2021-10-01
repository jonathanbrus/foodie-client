import 'package:flutter/material.dart';

//screens
import '../foodie/screens/home.dart';
import '../screens/products.dart';

import '../widgets/home_offers.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Food And Drinks",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 4,
          margin: EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(FoodieHome.routeName),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/foodanddrinks.jpg"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Home Needs",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(2),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductsScreen.routeName,
                      arguments: ["Groceries", "groceries"]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      "assets/groceries.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductsScreen.routeName,
                      arguments: ["Vegetables", "vegetables"]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      "assets/vegetables.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductsScreen.routeName,
                      arguments: ["Fruits", "fruits"]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      "assets/fruits.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductsScreen.routeName,
                      arguments: ["Fish And Meat", "meat"]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      "assets/fishandmeat.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Accessories",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsScreen.routeName,
                arguments: ["Cosmetics", "cosmetics"]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/cosmetics.png"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsScreen.routeName,
                arguments: ["Gifts", "gifts"]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/gifts.png"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsScreen.routeName,
                arguments: ["HeadPhones", "headphones"]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/headphones.png"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsScreen.routeName,
                arguments: ["Mobile Cases", "mobilecases"]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/mobilecases.png"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Home Made Products",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsScreen.routeName,
                arguments: ["Home Made Products", "homemade"]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/homemade.jpg"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Offer Zone",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HomeOfferButtons(),
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
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.only(top: 22, bottom: 12, left: 8, right: 8),
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
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Eat Good, Feel Good",
                      style: TextStyle(
                        fontSize: width * 0.036,
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
          right: width * 0.03,
          bottom: width * 0.048,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(FoodieHome.routeName),
            child: Container(
              width: width * 0.26,
              height: width * 0.26,
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

// const List categories = [
//   {
//     "title": "Groceries",
//     "category": "groceries",
//     "img": "assets/catImages/Gro.png",
//   },
//   {
//     "title": "Fruits",
//     "category": "fruits",
//     "img": "assets/catImages/Fru.png",
//   },
//   {
//     "title": "Vegetables",
//     "category": "vegetables",
//     "img": "assets/catImages/Veg.png",
//   },
//   {
//     "title": "Meat",
//     "category": "meat",
//     "img": "assets/catImages/Mea.png",
//   },
//   {
//     "title": "Home Made",
//     "category": "homemade",
//     "img": "assets/catImages/Hom.png",
//   },
//   {
//     "title": "Gifts",
//     "category": "gifts",
//     "img": "assets/catImages/Gif.png",
//   },
//   {
//     "title": "Headphones",
//     "category": "headphones",
//     "img": "assets/catImages/Hea.png",
//   },
//   {
//     "title": "Mobile cases",
//     "category": "mobilecases",
//     "img": "assets/catImages/Mob.png",
//   },
//   {
//     "title": "Cosmetics",
//     "category": "cosmetics",
//     "img": "assets/catImages/Cos.png",
//   },
// ];
