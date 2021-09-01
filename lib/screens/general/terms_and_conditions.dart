import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  static const routeName = "/contact-us";
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Terms & Conditions"),
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
                    "Terms & Conditions",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''These terms of usage (the "Terms of Use") direct your use of our "Alo Foodie" application for portable and handheld devices (the "Application"). The App are commonly implied as the "platform". In the event that it's not all that much difficulty read these Terms of Use mindfully before you use the service.'''),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      '''If you don't agree to these Terms of Use, you may not use the service on the Platform, and we request you to uninstall the App. By presenting, downloading or even just using the Platform, you will contract with Alo Foodie and you mean your affirmation to this Terms of Use and other Alo Foodie methodologies (checking anyway not limited to the Cancellation and Refund Policy, Privacy Policy and Take Down Policy) as posted on the Platform and changed sometimes, which produces results on the date on which you download, present or use the Platform, and make a legally confining arrangement to submit to the same.'''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
