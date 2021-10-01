import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

import '../screens/payments.dart';
import '../screens/add_address.dart';

class SelectAddress extends StatefulWidget {
  final bool food;
  const SelectAddress({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  int _index = 0;

  void setIndex(int? index) {
    setState(() {
      _index = int.parse("$index");
    });
  }

  @override
  Widget build(BuildContext context) {
    final addresses = Provider.of<User>(context).addresses;
    final double height = addresses.length < 3
        ? (addresses.length * 99) + 108
        : MediaQuery.of(context).size.height * 0.48;

    return Container(
      height: height,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "Select Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: addresses.length == 0
                      ? null
                      : () => Navigator.of(context).popAndPushNamed(
                            PaymentsScreen.routeName,
                            arguments: [_index, widget.food],
                          ),
                  child: Text("To Payment"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.black,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...addresses.map((address) {
                  int i = addresses.indexOf(address);
                  return Container(
                    margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: i == _index
                          ? Theme.of(context).primaryColor.withOpacity(0.26)
                          : Colors.grey.withOpacity(0.24),
                    ),
                    child: RadioListTile<int?>(
                      title: Address(address: address),
                      value: i,
                      groupValue: _index,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      onChanged: (int? value) {
                        setIndex(value);
                      },
                    ),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).popAndPushNamed(
                      AddAddressScreen.routeName,
                    ),
                    icon: Icon(
                      Icons.add_rounded,
                      size: 20,
                    ),
                    label: Text("Add Address"),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      primary: Colors.black,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Address extends StatelessWidget {
  final address;
  const Address({required this.address, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.fullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            address.phone,
            style: TextStyle(fontSize: 13),
          ),
          Text(
            address.address,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            address.city + " - " + address.pincode,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

void showSelectAddress(BuildContext context, bool food) => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SelectAddress(
            food: food,
          ),
        );
      },
    );
