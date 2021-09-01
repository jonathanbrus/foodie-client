import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_data.dart';
import '../models/auth_data.dart';

import '../helpers/auth_helper.dart';
import '../models/failure.dart';

class Auth with ChangeNotifier {
  UserData? _userData;
  AuthData? _authData;

  bool _authenticated = false;

  bool get authenticated {
    return _authenticated;
  }

  UserData get userData {
    return UserData(
      name: _userData!.name,
      mailId: _userData!.mailId,
      phone: _userData!.phone,
      isPrime: _userData!.isPrime,
      addresses: _userData!.addresses,
      wishlist: _userData!.wishlist,
    );
  }

  String get authToken {
    return _authData!.token;
  }

  // http://10.0.2.2:5000/

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    var url = Uri.parse("http://10.0.2.2:5000/sign-up");

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

      setData(
        decoded: decoded,
        email: email,
        password: password,
      );

      _authenticated = true;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
    notifyListeners();
  }

  Future<void> signIn({required email, required password}) async {
    var url = Uri.parse("http://10.0.2.2:5000/sign-in");
    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      final decoded = json.decode(response.body);

      print(decoded);

      if (decoded["statusCode"] != 200) {
        throw Failure(decoded["message"]);
      }

      final List result = await setData(
        decoded: decoded,
        email: email,
        password: password,
      );

      _userData = result[0];
      _authData = result[1];
      _authenticated = true;

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    clearData();
    _authenticated = false;

    _userData = null;
    _authData = null;

    notifyListeners();
  }

  Future<bool> autoLogin() async {
    final List result = await getData();

    if (result.length == 1) {
      _authenticated = result[0];
    } else {
      _authenticated = result[0];
      _userData = result[1];
      _authData = result[2];
    }

    return _authenticated;
  }

  Future<void> updateProfile() async {
    var url = Uri.parse("https://alofoodie-v2.herokuapp.com/updateProfile");
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

  Future<void> addAddress({
    required fullName,
    required phoneNo,
    required pincode,
    required city,
    required state,
    required doorNo,
    required street,
  }) async {
    var url = Uri.parse("https://alofoodie-v2.herokuapp.com/user/addAddress");
    // try {
    final response = await http.post(url, body: {
      "fullName": fullName,
      "phoneNo": phoneNo,
      "pincode": pincode,
      "city": city,
      "state": state,
      "doorNo": doorNo,
      "street": street,
    }, headers: {
      // HttpHeaders.authorizationHeader: '${_authData["token"]}',
    });

    final decoded = json.decode(response.body);

    print(decoded);

    // _userData = {
    //   ..._userData,
    //   "userAddress": [..._userData["userAddress"], decoded["addedAddress"]]
    // };

    // final prefs = await SharedPreferences.getInstance();

    // final encodedUserData = json.encode({
    //   "userId": _userData["userId"],
    //   "name": _userData["name"],
    //   "email": _userData["email"],
    //   "phone": _userData["phone"],
    //   "userAddress": _userData["userAddress"]
    // });

    //   prefs.setString('userData', encodedUserData);
    // } catch (e) {
    //   print(e);
    // }
    // notifyListeners();
  }

  Future<void> deleteAddress(int index) async {
    // final updated = _userData["userAddress"] as List;
    // updated.removeAt(index);

    // _userData = {..._userData, "userAddress": updated};

    // final prefs = await SharedPreferences.getInstance();

    // final encodedUserData = json.encode({
    //   "userId": _userData["userId"],
    //   "name": _userData["name"],
    //   "email": _userData["email"],
    //   "phone": _userData["phone"],
    //   "userAddress": _userData["userAddress"]
    // });

    // prefs.setString('userData', encodedUserData);

    var url =
        Uri.parse("https://alofoodie-v2.herokuapp.com/user/deleteAddress");

    // try {
    await http.post(url, body: {
      "index": "$index"
    }, headers: {
      // HttpHeaders.authorizationHeader: '${_authData["token"]}',
    });
    // } catch (e) {
    // print(e);
    // }

    // notifyListeners();
  }
}
