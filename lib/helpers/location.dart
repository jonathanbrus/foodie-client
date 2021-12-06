import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geodesy/geodesy.dart';

Future getLocation() async {
  Location location = new Location();

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
