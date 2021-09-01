import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/addresses.dart';
import '../models/user_data.dart';
import '../models/auth_data.dart';

Future<List> setData({
  required decoded,
  required email,
  required password,
}) async {
  final prefs = await SharedPreferences.getInstance();

  final String name = decoded["user"]["name"];
  final String mailId = decoded["user"]["email"];
  final int phone = decoded["user"]["phone"];
  final bool isPrime =
      decoded["user"]["isPrime"] == null ? false : decoded["user"]["isPrime"];
  // final List<String> wishlist = [
  //   ...decoded["user"]["wishlist"].map((prod) => prod)
  // ];
  final String token = decoded["token"];

  List<Address> addresses = [
    ...decoded["user"]["userAddress"].map(
      (address) => Address(
        fullName: address["fullName"],
        phone: int.parse(address["phoneNo"]),
        pincode: int.parse(address["pincode"]),
        address: address["street"],
        city: address["city"],
        state: address["state"],
      ),
    )
  ];

  await prefs.setString("name", name);
  await prefs.setString("mailId", mailId);
  await prefs.setInt("phone", phone);
  await prefs.setBool("isPrime", isPrime);
  await prefs.setString("password", password);
  await prefs.setString("addresses", json.encode(addresses));
  await prefs.setString("token", token);

  return [
    UserData(
      name: name,
      mailId: mailId,
      phone: phone,
      isPrime: isPrime,
      addresses: addresses,
      wishlist: [],
    ),
    AuthData(
      email: email,
      password: password,
      token: token,
    ),
  ];
}

Future<List> getData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.reload();

  if (prefs.getKeys().contains("token")) {
    final name = prefs.getString("name");
    final mailId = prefs.getString("mailId");
    final phone = prefs.getInt("phone");
    final isPrime = prefs.getBool("isPrime");
    final password = prefs.getString("password");
    final addressesJson = prefs.getString("addresses");
    final token = prefs.getString("token");

    final decoded = json.decode("$addressesJson");

    List<Address> addresses = [
      ...decoded.map(
        (address) => Address(
          fullName: address["fullName"],
          phone: address["phone"],
          pincode: address["pincode"],
          address: address["address"],
          city: address["city"],
          state: address["state"],
        ),
      )
    ];

    return [
      true,
      UserData(
        name: "$name",
        mailId: "$mailId",
        phone: int.parse("$phone"),
        isPrime: "$isPrime" == "true",
        addresses: addresses,
        wishlist: ["ad"],
      ),
      AuthData(
        email: "$mailId",
        password: "$password",
        token: "$token",
      ),
    ];
  } else {
    return [false];
  }
}

void clearData() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.clear();
}
