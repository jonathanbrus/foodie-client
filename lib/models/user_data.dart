import './addresses.dart';

class UserData {
  String name;
  String email;
  int phone;
  bool isPrime;
  List<Address> addresses;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.isPrime,
    required this.addresses,
  });
}
