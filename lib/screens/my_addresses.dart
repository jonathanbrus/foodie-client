import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

import 'add_address.dart';

class MyAddressesScreen extends StatefulWidget {
  static const routeName = "/my-address";
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  _MyAddressesScreenState createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final addresses = user.addresses;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("My Addresses"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            ...addresses.map(
              (address) => Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "+91 " + address.phone,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      address.address,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${address.city} - ${address.pincode}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => user.deleteAddress(
                            addresses.indexOf(address),
                          ),
                          icon: Icon(Icons.delete_forever),
                          label: Text("Delete"),
                          style: TextButton.styleFrom(primary: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Add",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add_rounded),
        onPressed: () =>
            Navigator.of(context).pushNamed(AddAddressScreen.routeName),
      ),
    );
  }
}
