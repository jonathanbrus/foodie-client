import 'package:flutter/material.dart';
import '../screens/general/prime_notice.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5.6),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => PrimeNotice())),
        child: Container(
          width: double.infinity,
          height: 66,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              "assets/banner.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
