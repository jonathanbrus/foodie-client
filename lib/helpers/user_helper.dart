import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/address.dart';

Future<Map<String, dynamic>> setData({
  required data,
  required password,
}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.reload();

  final String name = data["name"];
  final String email = data["email"];
  final String phone = data["phone"];
  final bool primeMember = data["primeMember"];

  List<Address> addresses = [
    ...data["addresses"].map(
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

  await prefs.setString("name", name);
  await prefs.setString("email", email);
  await prefs.setString("phone", phone);
  await prefs.setBool("primeMember", primeMember);
  await prefs.setString("password", password);
  await prefs.setString("addresses", json.encode(addresses));
  await prefs.setString("authToken", data["authToken"]);

  return {
    "name": name,
    "email": email,
    "phone": phone,
    "primeMember": primeMember,
    "addresses": addresses,
    "authToken": data["authToken"]
  };
}

Future<Map<String, dynamic>> getData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.reload();

  if (prefs.getKeys().contains("authToken")) {
    final name = prefs.getString("name");
    final email = prefs.getString("email");
    final phone = prefs.getString("phone");
    final primeMember = prefs.getBool("primeMember");
    final addressesJson = prefs.getString("addresses");
    final authToken = prefs.getString("authToken");

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

    return {
      "name": name,
      "email": email,
      "phone": phone,
      "primeMember": primeMember,
      "addresses": addresses,
      "authToken": authToken
    };
  } else {
    return {
      "authenticated": false,
    };
  }
}

void clearData() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.clear();
}

Future<List<Address>> updateAddress({
  required List rawAddresses,
}) async {
  final prefs = await SharedPreferences.getInstance();

  List<Address> addresses = [
    ...rawAddresses.map(
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

  await prefs.setString("addresses", json.encode(addresses));

  return addresses;
}
