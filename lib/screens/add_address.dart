import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

import '../../../ui_widgets/loader.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = "/add-address";
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  AddAddressScreenState createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {
  final _form = GlobalKey<FormState>();

  bool _loader = false;

  Map<String, dynamic> _address = {
    "fullName": "",
    "phone": "",
    "pincode": "",
    "city": "",
    "state": "",
    "address": ""
  };

  _submitForm(context) async {
    bool isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _loader = true;
    });

    try {
      await Provider.of<User>(context, listen: false).addAddress(
        fullName: _address["fullName"],
        phone: _address["phone"],
        pincode: _address["pincode"],
        address: _address["address"],
        city: _address["city"],
        state: _address["state"],
      );
      setState(() {
        _loader = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Add Address"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Full Name"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["fullName"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                      if (value.length < 4) {
                        return "Please enter full name.";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Phone Number"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["phone"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                      if (value.length < 10) {
                        return "Enter valid phone number.";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Pincode"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["pincode"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                      if (value.length < 6) {
                        return "";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "City"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["city"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "State"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["state"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Address"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["address"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                    },
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: Theme.of(context).accentColor,
                      ),
                      onPressed: () =>
                          _loader ? () => {} : _submitForm(context),
                      child: _loader
                          ? Loader()
                          : Text(
                              "Save Address",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
