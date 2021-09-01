import './addresses.dart';

class UserData {
  String name;
  String mailId;
  int phone;
  bool isPrime;
  List<Address> addresses;
  List<String> wishlist;

  UserData({
    required this.name,
    required this.mailId,
    required this.phone,
    required this.isPrime,
    required this.addresses,
    required this.wishlist,
  });
}
