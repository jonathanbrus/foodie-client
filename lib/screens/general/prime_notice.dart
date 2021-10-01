import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrimeNotice extends StatelessWidget {
  const PrimeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Alo Prime Membership"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Text(
              "Dear Customer Of ALO, We Are Offering A Number Of Rare Offers To All Customers Who Join The ALO PRIME Plan :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ...list1.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          e,
                          maxLines: 3,
                          style: TextStyle(fontSize: 14, height: 1.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text(
              "ALO-வின் அன்பார்ந்த வாடிக்கையாளர்களே ALO PRIME திட்டத்தில் இணையும் அனைத்து வாடிக்கையாளர்களுக்கு அரிய  பல சலுகைகளை வழங்குகிறோம் :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ...list2.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          e,
                          maxLines: 3,
                          style: TextStyle(fontSize: 14, height: 1.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
            Container(
              height: 44,
              margin: EdgeInsets.only(top: 8, right: 12, left: 12),
              child: ElevatedButton(
                onPressed: () => launchUrl(context, "tel:+91 8778796511"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Contact For more details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.phone_callback_rounded,
                      size: 19,
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List list1 = [
  "Pay Just Rs.500 And Join This Scheme.",
  "Delivery Is Free For All Your Purchases (LIFE TIME).",
  "5% Discount On All Orders.",
  "The Other Products You Ordered Will Be Delivered Within 7 Hours.",
  "Special Prizes Will Be Given On All Festival Days.",
  "Use in Conjunction with This Project.",
  "This Offer I Only For The First 100 Customers Who Join This scheme.",
  "ALO PRIME CARD Will Be Provided To The Customers Who Join This Scheme."
];

List list2 = [
  "ரூபாய் 500 மட்டும் செலுத்தி இந்த திட்டத்தில் இணைந்திடுங்ள்.",
  "அனைத்து பொருட்களுக்கும் டெலிவரி இலவசம் (LIFE TIME).",
  "அனைத்து பொருட்களுக்கும் 5% தள்ளுபடி.",
  "பிற பொருட்கள் 7 மணி நேரத்தில் டெலிவரி செய்து தரப்படும்.",
  "அனைத்து பண்டிகை நாட்களிலும்  சிறப்பு பரிசுகள் வழங்கப்படும்.",
  "இந்த திட்டத்தில் இணைந்து பயன்படுங்கிகள்.",
  "இந்த சலுகாய் இந்த திட்டத்தில் முதல் 100 வாடிக்கையாளர்களுக்கு மட்டுமே.",
  "இந்த திட்டத்தில் இணையும் வாடிக்கையாளர்களுக்கு ALO PRIME பதிவு வழங்ப்படும்."
];

void launchUrl(BuildContext context, String url) async {
  await canLaunch(url)
      ? await launch(url)
      : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong when launching URL"),
          ),
        );
}
