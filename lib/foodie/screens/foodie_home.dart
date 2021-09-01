import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/restaurants.dart';

import '../widgets/home_carousal.dart';
import '../../ui_widgets/restaurant_item.dart';
import '../../widgets/search_field.dart';
import '../../ui_widgets/loader.dart';

class FoodieHome extends StatefulWidget {
  static const routeName = "foodie-home";

  const FoodieHome({Key? key}) : super(key: key);

  @override
  _FoodieHomeState createState() => _FoodieHomeState();
}

class _FoodieHomeState extends State<FoodieHome> {
  late String _search = "";

  void setSearch(search) {
    setState(() {
      _search = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsProvider = Provider.of<Restaurants>(context);

    restaurantsProvider.fetchAllRestaurents();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Food & Drinks"),
        bottom: PreferredSize(
          child: SearchField(
            hint: "Search",
            setSearch: setSearch,
          ),
          preferredSize: Size(double.infinity, 70),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: restaurantsProvider.getLocation(),
          builder: (BuildContext ctx, location) {
            if (location.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = location.data as Map<String, dynamic>;

              if (data["hasPermission"]) {
                if (restaurantsProvider.getAllRestaurents.length > 0) {
                  return RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2.6,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () {
                      restaurantsProvider.setLoaded();
                      return restaurantsProvider.fetchAllRestaurents();
                    },
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 12),
                      children: [
                        if (_search.length == 0)
                          ...showIfNoSearch(
                            lat: data["lat"],
                            long: data["long"],
                            context: context,
                          ),
                        ...restaurantsNearYou(
                          _search.length > 0
                              ? restaurantsProvider
                                  .nearByRestaurants(
                                    data["lat"],
                                    data["long"],
                                  )
                                  .where(
                                    (res) => res.name.toLowerCase().contains(
                                          _search.toLowerCase(),
                                        ),
                                  )
                                  .toList()
                              : restaurantsProvider.nearByRestaurants(
                                  data["lat"],
                                  data["long"],
                                ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Loader(),
                  );
                }
              } else {
                return Center(
                  child: Text("Enable Location"),
                );
              }
            } else {
              return Center(
                child: Loader(),
              );
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
  final double lat;
  final double long;

  const PopularRestaurants({required this.lat, required this.long, Key? key})
      : super(key: key);

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
            final res = restaurants.popularRestaurants(lat, long)[i];

            return RestaurantItem(
              id: res.id,
              name: res.name,
              image: res.image,
              city: res.city,
              isActive: res.isActive,
              offer: res.offer,
              from: res.from,
              to: res.to,
              rating: res.rating,
              distance: res.distance!,
              margin: i + 1 != restaurants.popularRestaurants(lat, long).length
                  ? 0
                  : 12,
              bottomMargin: 12,
            );
          },
          itemCount: restaurants.popularRestaurants(lat, long).length,
        ),
      ),
    );
  }
}

showIfNoSearch(
    {required double lat,
    required double long,
    required BuildContext context}) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight =
      mediaQuery.size.height - mediaQuery.viewInsets.horizontal;

  final list = [
    HomeCarousel(screenHeight: screenHeight),
    Title(title: "Popular"),
    PopularRestaurants(
      lat: lat,
      long: long,
    ),
    Title(
      title: "Restaurants Nearby",
    ),
  ];

  return list.map((e) => e);
}

restaurantsNearYou(List<Restaurent> allRestaurants) {
  if (allRestaurants.length > 0) {
    return allRestaurants.map(
      (res) => RestaurantItem(
        id: res.id,
        name: res.name,
        image: res.image,
        city: res.city,
        isActive: res.isActive,
        offer: res.offer,
        from: res.from,
        to: res.to,
        rating: res.rating,
        distance: res.distance!,
        margin: 12,
        bottomMargin: 0,
      ),
    );
  } else {
    final list = [
      Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Image.asset("assets/emptyRes.png"),
              ),
              Text("No Restaurants found around 7 km."),
            ],
          ),
        ),
      ),
    ];
    return list.map((e) => e);
  }
}
