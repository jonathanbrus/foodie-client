import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../helpers/location.dart';
import '../../models/restaurant.dart';

class Restaurants with ChangeNotifier {
  List<Restaurent> _nearByRestaurants = [];
  List<Restaurent> _popularRestaurents = [];
  String _search = "";
  bool loaded = false;

  String get search {
    return _search;
  }

  void setSearch(search) {
    _search = search;
    notifyListeners();
  }

  void clearSearch() {
    _search = "";
  }

  List<Restaurent> get nearByRestaurants {
    List<Restaurent> openedRes = [];
    List<Restaurent> closedRes = [];

    _nearByRestaurants.forEach((res) {
      if (res.active == true &&
          res.from <= DateTime.now().hour &&
          res.to > DateTime.now().hour) {
        openedRes.add(res);
      } else {
        closedRes.add(res);
      }
    });

    return [
      ...[
        ...openedRes,
        ...closedRes
      ].where((res) => res.name.toLowerCase().contains(_search.toLowerCase()))
    ];
  }

  List<Restaurent> get popularRestaurents {
    return [..._popularRestaurents];
  }

  void setLoaded() {
    loaded = false;
  }

  Future<void> fetchAllRestaurents(lat, long) async {
    if (!loaded) {
      try {
        final response = await http
            .get(Uri.parse("https://alofoodie.herokuapp.com/restaurants"));

        List decoded = json.decode(response.body)["data"];

        final nearby = [];
        final popular = [];

        decoded.forEach((res) {
          final resLat =
              res["geoPoint"] != null ? res["geoPoint"]["lat"] : 8.083804;
          final resLong =
              res["geoPoint"] != null ? res["geoPoint"]["long"] : 77.551894;

          final resturant = Restaurent(
            id: res["_id"],
            name: res["name"],
            image: res["image"],
            city: res["city"],
            popular: res["popular"],
            topPicks: res["topPicks"],
            rating: res["rating"] + 0.1,
            active: res["active"],
            offer: res["offer"],
            from: res["timing"]["from"],
            to: res["timing"]["to"],
            distance: getDistance(lat, long, resLat, resLong),
          );

          if (resturant.popular) {
            popular.add(resturant);
          } else if (resturant.distance <= 7) {
            nearby.add(resturant);
          }
        });
        _nearByRestaurants = [...nearby];
        _popularRestaurents = [...popular];
        loaded = true;
      } catch (e) {
        print("from res " + e.toString());
      }
      notifyListeners();
    }
  }
}
