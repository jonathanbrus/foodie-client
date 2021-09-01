import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = "/about-us";
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreeState createState() => _AboutUsScreeState();
}

class _AboutUsScreeState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("About Us"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''Alo foodie, is one of the fastest food delivery app. Alo foodie is available now in KANYAKUMARI, Whether you’re looking for biryani to feed your desi cravings, soul comforting pizzas and burgers, or even a salad with a cup of chai or coffee, Alo foodie  is the only app you need for the quickest doorstep delivery of your favorites.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Popular Restaurants",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''Find your favorite local restaurants, as well as top chains like Dominos, KFC, 50Bucks, Meat and eat, King’s chic, and more. Use our search filters to discover healthy places nearby for breakfast, lunch or dinner, and refer to our theme-based curated lists called ‘Collections’ to find the best burgers, or the top trending restaurants in town.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Avail food offers and discounts",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''Get exciting deals on both - food delivery and dining.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Opt for contactless food delivery and dining",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''Ensure maximum safety and hygiene by opting for contactless food delivery and dining.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Best Supermarkets",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''Order fresh fruits & vegetables, daily essentials, and all household items from top-rated supermarkets in your city, via our Grocery section. Shop online for your daily needs.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Access restaurant details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "Look up restaurant menus, ratings, reviews, photos, contact details, map directions, and all the other essential information you need for your next meal - all in one place. Also, rate restaurants to help other foodies make informed decisions."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
