class Address {
  String fullName;
  int phone;
  int pincode;
  String address;
  String city;
  String state;

  Address({
    required this.fullName,
    required this.phone,
    required this.pincode,
    required this.address,
    required this.city,
    required this.state,
  });

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "pincode": pincode,
        "address": address,
        "city": city,
        "state": state,
      };
}
