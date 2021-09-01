import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';

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
    final auth = Provider.of<Auth>(context);

    final addresses = auth.userData.addresses;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("My Address"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(10),
                      primary: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AddAddressScreen.routeName),
                    icon: Icon(Icons.add),
                    label: Text(
                      "Add Address",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ...addresses.map(
                  (address) => Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(address.fullName),
                            Text("${address.phone}"),
                            Text(address.address),
                            Text("${address.city} - ${address.pincode}"),
                          ],
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: () =>
                                auth.deleteAddress(addresses.indexOf(address)),
                            icon: Icon(Icons.delete_forever),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
