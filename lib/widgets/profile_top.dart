import 'package:flutter/material.dart';

class ProfileTop extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfileTop(
      {required this.name, required this.email, required this.phone, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 120,
              ),
            ),
            radius: 80,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.verified_user, size: 20)
                ],
              ),
              SizedBox(height: 8),
              Text(email),
              SizedBox(height: 8),
              Text("+91 " + phone.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
