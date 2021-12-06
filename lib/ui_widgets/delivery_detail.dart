import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class DeliveryDetail extends StatelessWidget {
  final int index;
  const DeliveryDetail({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.24),
      ),
      child: Consumer<User>(builder: (context, user, _) {
        final address = user.addresses[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  address.fullName,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  address.phone,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Flexible(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      address.address,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "City",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  address.city + address.pincode,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
