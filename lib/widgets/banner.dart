import 'package:flutter/material.dart';
import '../screens/general/prime_notice.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => PrimeNotice())),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: RadialGradient(
                  colors: [
                    Color(0xffE67ACB),
                    Color(0xff00A4EC),
                  ],
                  radius: 6,
                  center: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get better benefits on each prodcuts and orders !!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Join Alo Prime Membership",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black12,
                        ),
                        child: Text(
                          "Click Here",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 10,
              bottom: 4,
              child: Image.asset(
                "assets/offer.png",
                fit: BoxFit.cover,
                width: 52,
                height: 52,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
