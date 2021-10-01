import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';

import '../helpers/user_helper.dart';
import '../models/failure.dart';

class User with ChangeNotifier {
  bool _authenticated = false;
  bool _primeMember = false;
  String _authToken = "";
  String _name = "";
  String _email = "";
  String _phone = "";
  List<Address> _addresses = [];

  bool get authenticated {
    return _authenticated;
  }

  bool get primeMember {
    return _primeMember;
  }

  String get authToken {
    return _authToken;
  }

  String get name {
    return _name;
  }

  String get email {
    return _email;
  }

  String get phone {
    return _phone;
  }

  List get addresses {
    return [..._addresses];
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/sign-up");

    try {
      final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      });

      final decoded = json.decode(response.body);

      if (decoded["statusCode"] != 201) {
        throw Failure(decoded["message"]);
      }

      final Map<String, dynamic> data = await setData(
        user: decoded["user"],
        authToken: decoded["authToken"],
        password: password,
      );

      _authenticated = true;
      _primeMember = data["primeMember"];
      _authToken = data["authToken"];
      _name = data["name"];
      _email = data["email"];
      _phone = data["phone"];
      _addresses = data["addresses"];

      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signIn({required email, required password}) async {
    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/sign-in");
    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      final decoded = json.decode(response.body);

      if (decoded["statusCode"] != 200) {
        throw Failure(decoded["message"]);
      }

      final Map<String, dynamic> data = await setData(
        user: decoded["user"],
        authToken: decoded["authToken"],
        password: password,
      );

      _authenticated = true;
      _primeMember = data["primeMember"];
      _authToken = data["authToken"];
      _name = data["name"];
      _email = data["email"];
      _phone = data["phone"];
      _addresses = data["addresses"];

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    _authenticated = false;
    clearData();

    notifyListeners();
  }

  Future<bool> autoLogin() async {
    final Map<String, dynamic> data = await getData();

    if (data.length == 1) {
      _authenticated = false;
    } else {
      _authenticated = true;
      _primeMember = data["primeMember"];
      _authToken = data["authToken"];
      _name = data["name"];
      _email = data["email"];
      _phone = data["phone"];
      _addresses = data["addresses"];
    }

    return _authenticated;
  }

  Future<void> addAddress({
    required fullName,
    required phone,
    required pincode,
    required address,
    required city,
    required state,
  }) async {
    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/addAddress");
    try {
      final response = await http.post(url, body: {
        "fullName": fullName,
        "phone": phone,
        "pincode": pincode,
        "city": city,
        "state": state,
        "address": address
      }, headers: {
        HttpHeaders.authorizationHeader: _authToken,
      });

      final decoded = json.decode(response.body);

      _addresses = await updateAddress(rawAddresses: decoded["addresses"]);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAddress(int index) async {
    var url = Uri.parse("https://alofoodie-1.herokuapp.com/user/deleteAddress");

    try {
      final response = await http.post(url, body: {
        "index": "$index"
      }, headers: {
        HttpHeaders.authorizationHeader: _authToken,
      });

      final decoded = json.decode(response.body);

      _addresses = await updateAddress(rawAddresses: decoded["addresses"]);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

Future<void> updateProfile() async {
  var url = Uri.parse("https://alofoodie-1.herokuapp.com/updateProfile");
  try {
    final response = await http.post(url, body: {
      "name": "",
      "email": "",
      "phone": "",
    });
    print(response.body);
  } catch (e) {
    print(e);
  }
}

Future<void> changePassword(
    {required String userId, required String password}) async {
  var url = Uri.parse("https://alofoodie-1.herokuapp.com/change-password");

  try {
    final response = await http.post(url, body: {
      "userId": userId,
      "password": password,
    });

    print(response.body);
  } catch (e) {
    throw Failure("e");
  }
}
