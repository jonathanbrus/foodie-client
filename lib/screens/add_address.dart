import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';

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
    "FullName": "",
    "PhoneNo": "",
    "Pincode": "",
    "City": "",
    "State": "",
    "DoorNo": "",
    "Street": "",
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
      await Provider.of<Auth>(context, listen: false).addAddress(
        fullName: _address["FullName"],
        phoneNo: _address["PhoneNo"],
        pincode: _address["Pincode"],
        city: _address["City"],
        state: _address["State"],
        doorNo: _address["DoorNo"],
        street: _address["Street"],
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
        toolbarHeight: 76,
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
                      _address["FullName"] = value;
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
                      _address["PhoneNo"] = value;
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
                      _address["Pincode"] = value;
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
                      _address["City"] = value;
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
                      _address["State"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "House No, Building Name"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["DoorNo"] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Road name (or) Area name (or) Colony"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _address["Street"] = value;
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
