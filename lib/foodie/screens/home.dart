import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../providers/restaurants.dart';
import '../../helpers/location.dart';
import '../providers/foods.dart';

import '../../ui_widgets/home_carousal.dart';
import '../widgets/restaurant_item.dart';
import '../../widgets/search_field.dart';
import '../../ui_widgets/loader.dart';
import "../../models/restaurant.dart";

class FoodieHome extends StatefulWidget {
  static const routeName = "foodie-home";

  const FoodieHome({Key? key}) : super(key: key);

  @override
  _FoodieHomeState createState() => _FoodieHomeState();
}

class _FoodieHomeState extends State<FoodieHome> {
  @override
  void didChangeDependencies() {
    Provider.of<Restaurants>(context, listen: false).clearSearch();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Food & Drinks"),
        bottom: PreferredSize(
          child: Consumer<Restaurants>(builder: (context, res, ch) {
            return SearchField(
              hint: "Search",
              setSearch: res.setSearch,
            );
          }),
          preferredSize: Size(double.infinity, 70),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getLocation(),
          builder: (BuildContext ctx, location) {
            switch (location.connectionState) {
              case ConnectionState.done:
                Map<String, dynamic> data =
                    location.data as Map<String, dynamic>;
                if (!data["hasPermission"]) {
                  return Center(child: Text("Enable Location"));
                }
                return Consumer<Restaurants>(
                    builder: (context, restaurantsProvider, ch) {
                  return FutureBuilder(
                    future: restaurantsProvider.fetchAllRestaurents(
                      data["lat"],
                      data["long"],
                    ),
                    builder: (BuildContext ctx, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return RefreshIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: 2.6,
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            onRefresh: () {
                              Provider.of<Foods>(context, listen: false)
                                  .setempty();
                              restaurantsProvider.setLoaded();
                              return restaurantsProvider.fetchAllRestaurents(
                                data["lat"],
                                data["long"],
                              );
                            },
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 12),
                              children: [
                                if (restaurantsProvider.search.length == 0)
                                  SearchInActive(),
                                SearchActive(
                                  allRestaurants:
                                      restaurantsProvider.nearByRestaurants,
                                ),
                              ],
                            ),
                          );
                        default:
                          return Center(child: Loader());
                      }
                    },
                  );
                });
              default:
                return Center(child: Loader());
            }
          },
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PopularRestaurants extends StatelessWidget {
  const PopularRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 286,
      child: Consumer<Restaurants>(
        builder: (BuildContext ctx, restaurants, ch) => ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctx, int i) {
            final res = restaurants.popularRestaurents[i];

            return RestaurantItem(
              id: res.id,
              name: res.name,
              image: res.image,
              city: res.city,
              isActive: res.active,
              offer: res.offer,
              from: res.from,
              to: res.to,
              rating: res.rating,
              distance: res.distance,
              margin: i + 1 != restaurants.popularRestaurents.length ? 0 : 12,
              bottomMargin: 12,
            );
          },
          itemCount: restaurants.popularRestaurents.length,
        ),
      ),
    );
  }
}

class SearchInActive extends StatelessWidget {
  SearchInActive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight =
        mediaQuery.size.height - mediaQuery.viewInsets.horizontal;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeCarousel(
          uri: "foodiehome",
          screenHeight: screenHeight,
        ),
        Title(title: "Popular"),
        PopularRestaurants(),
        Title(
          title: "Restaurants Nearby",
        ),
      ],
    );
  }
}

class SearchActive extends StatelessWidget {
  final List<Restaurent> allRestaurants;
  SearchActive({required this.allRestaurants, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<Restaurants>(context).nearByRestaurants;

    if (restaurants.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Lottie.asset(
                  "assets/lottie/emptyRes.json",
                  repeat: true,
                ),
              ),
              Text(
                "No restaurants found nearby.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: allRestaurants
            .map(
              (res) => RestaurantItem(
                id: res.id,
                name: res.name,
                image: res.image,
                city: res.city,
                isActive: res.active,
                offer: res.offer,
                from: res.from,
                to: res.to,
                rating: res.rating,
                distance: res.distance,
                margin: 12,
                bottomMargin: 0,
              ),
            )
            .toList(),
      );
    }
  }
}
