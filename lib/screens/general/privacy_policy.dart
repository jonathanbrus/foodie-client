import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static const routeName = "/privacy-policy";
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Privacy Policy"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''This Privacy ("Policy") depicts the policy and method on the variety, use, disclosure and affirmation of your information when you use our Alo foodie mobile application made open by Alo Groups of Pvt-Ltd("Alo", "Groups", "we", "us" and "our").'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''The expression "you" and "your" imply the user of the Alo foodie Platform.The term "administration" alludes any service offered by Alo foodie whether on the Alo foodie Platform or something else.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''You should peruse this Policy before using the Alo foodie Platform or submitting any personal information to Alo foodie. This Policy is a piece of and joined inside, and is to be scrutinized close by, the Terms of Use.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "YOUR CONSENT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''By utilizing the Alo Foodie Platform and the Services, you concur and agree to the arrangements, move, use, stockpiling, exposure and sharing of your data as depicted and collected by us as per this Policy. In case you disagree with the Policy, kindly don't use or get to the Alo foodie Platform.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "POLICY CHANGES",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''We may from time to time update this Policy and such changes will be posted on this page. On the off chance that we uncover any massive moves up to this Policy we will endeavour to furnish you with sensible notice of such changes, for example, through prominent notice on the Alo Foodie Platform or to your email address on record and where needed by proper law, we will get your assent. To the degree permitted under the pertinent law, you’re continued with use of our Services after we convey or send a notice about our movements to this Policy will build up your consent to the refreshed Policy.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "INFORMATION WE COLLECT FROM YOU",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "Concerning the entirety of your visits to the Alo Foodie Platform, we will therefore assemble and examine the going with section and other information:"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "• At the second that you talk with us (by means for email, telephone, through the Alo Foodie Platform or something else), we may keep up a record of your correspondence."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "• Location information: Depending on the Services that you use, and your application settings or contraption assents, we may gather your progressing information, or careful zone data as picked through information, for example, GPS, IP address."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "• Transaction Information: We collect transaction subtleties related to your utilization of our Services, and data about your development on the Services, including the full Uniform Resource Locators (URL), such a Services you referred to or gave remarks, district names, filed records picked, and number of clicks, etc."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "• Device Information: We may gather data about the gadgets you use to get to our Services, including the hardware models, working framework and structures, software, record names and forms, preferred languages, remarkable gadget identifiers, publicizing identifiers, serial numbers, gadget motion data and mobile network data. Examination organizations may utilize cell phone IDs to follow your utilization of the Kumari Foodie Platform."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "• If the restaurant partner, owner or a delivery partner, we will, furthermore, record your calls with us produced using the gadget used to offer Types of assistance, related call subtleties, SMS subtleties area and address details."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "COOKIES",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "Our Alo Foodie Platform and third party with whom we associate, may use cookies, pixel labels, web signals, cell phone IDs, flash cookies and relative archives or advances to accumulate and store information concerning your use of the Services and third part sites."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "ADVERTISING",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "We may work with third party, for example, network promoters to serve notices on the Alo Foodie Platform and on third party sites or other media (e.g., person to person communication stages). This third party may utilize cookies, JavaScript, web reference points (counting clear GIFs), Flash LSOs and other following advances to gauge the viability of their promotions and to customize publicizing content to you."),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "CONTACTING US",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "If you have got any queries on this Privacy Policy, contact details are provided email alofoodie3@gmail.com"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
