import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geodesy/geodesy.dart';
import 'package:http/http.dart' as http;

int getDistance(
  double startLat,
  double startLong,
  double endLat,
  double endLong,
) {
  var l1 = LatLng(startLat, startLong);
  var l2 = LatLng(endLat, endLong);

  final distance =
      (Geodesy().distanceBetweenTwoGeoPoints(l1, l2) / 1000).ceil();
  return distance.toInt();
}

class Restaurent {
  final String id;
  final String name;
  final String image;
  final String landmark;
  final String address;
  final String city;
  final double rating;
  final int offer;
  final bool isActive;
  final int from;
  final int to;
  final double lat;
  final double long;
  int? distance;

  Restaurent({
    required this.id,
    required this.name,
    required this.image,
    required this.landmark,
    required this.address,
    required this.city,
    required this.rating,
    required this.isActive,
    required this.offer,
    required this.from,
    required this.to,
    required this.lat,
    required this.long,
    this.distance,
  });
}

List names = ["KFC", "Dominos", "Dindigul Thalappakatti"];

class Restaurants with ChangeNotifier {
  List<Restaurent> _restaurents = [];
  bool loaded = false;
  Location location = new Location();

  List<Restaurent> get getAllRestaurents {
    return [..._restaurents];
  }

  List<Restaurent> popularRestaurants(double lat, double long) {
    return [
      ..._restaurents.where((res) => names.contains(res.name)).map((res) {
        res.distance = getDistance(lat, long, res.lat, res.long);
        return res;
      })
    ];
  }

  List<Restaurent> nearByRestaurants(double lat, double long) {
    List<Restaurent> openedRes = [];
    List<Restaurent> closedRes = [];

    _restaurents.forEach((res) {
      if (res.isActive == true &&
          res.from <= DateTime.now().hour &&
          res.to > DateTime.now().hour) {
        openedRes.add(res);
      } else {
        closedRes.add(res);
      }
    });

    return [
      ...[...openedRes, ...closedRes]
          .where((res) => getDistance(lat, long, res.lat, res.long) < 7)
          .map((res) {
        res.distance = getDistance(lat, long, res.lat, res.long);
        return res;
      })
    ];
  }

  void setLoaded() {
    loaded = false;
  }

  Future getLocation() async {
    LocationData _locationData;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    return {
      "lat": _locationData.latitude,
      "long": _locationData.longitude,
      "hasPermission": _permissionGranted == PermissionStatus.granted
    };
  }

  Future<void> fetchAllRestaurents() async {
    if (!loaded) {
      try {
        final response = await http.get(
            Uri.parse("https://alofoodie-v2.herokuapp.com/getAllRestaurants"));

        List decoded = json.decode(response.body)["allRestaurants"];

        _restaurents = decoded.map((res) {
          return Restaurent(
            id: res["_id"],
            name: res["name"],
            image: res["image"],
            landmark: res["restaurantAddress"]["landmark"],
            address: res["restaurantAddress"]["address"],
            city: res["restaurantAddress"]["city"],
            rating: res["rating"],
            isActive: res["isActive"],
            offer: res["offer"] != null ? res["offer"] : 20,
            from: res["timing"]["from"],
            to: res["timing"]["to"],
            lat: res["geoPoint"] != null ? res["geoPoint"]["lat"] : 8.083804,
            long: res["geoPoint"] != null ? res["geoPoint"]["long"] : 77.551894,
          );
        }).toList();
        loaded = true;
      } catch (e) {
        print("from res " + e.toString());
      }
      notifyListeners();
    }
  }
}
