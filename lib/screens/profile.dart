import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/user.dart';

//screen
import './auth/auth.dart';
import './my_addresses.dart';
import './general/about_us.dart';
import './general/terms_and_conditions.dart';
import './general/privacy_policy.dart';

import '../widgets/double_back.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/profile_top.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _showDialog(context, user) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Container(
          child: Text("Are you sure you want to sign out?"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              user.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AuthScreen.routeName,
                (route) => route.settings.name == AuthScreen.routeName,
              );
            },
            child: Text("Yes"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
      ),
      body: DoubleBack(
        child: SafeArea(
          child: ListView(
            children: [
              ProfileTop(
                name: user.name,
                email: user.email,
                phone: user.phone,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    // ListItem(
                    //   title: "Edit Profile",
                    //   leading: Icons.edit_rounded,
                    //   action: () {},
                    // ),
                    ListItem(
                      title: "Addresses",
                      leading: Icons.location_city_rounded,
                      action: () {
                        Navigator.of(context)
                            .pushNamed(MyAddressesScreen.routeName);
                      },
                    ),
                    ListItem(
                      title: "About Us",
                      leading: Icons.info_rounded,
                      action: () {
                        Navigator.of(context)
                            .pushNamed(AboutUsScreen.routeName);
                      },
                    ),
                    ListItem(
                      title: "Contact Us",
                      leading: Icons.phone_callback_rounded,
                      action: () => launchUrl(context, "tel:+91 8778796511"),
                    ),
                    ListItem(
                      title: "Send Feedback",
                      leading: Icons.messenger_rounded,
                      action: () => launchUrl(
                          context, "whatsapp://send?phone=+91 8778796511"),
                    ),
                    ListItem(
                      title: "Terms and Conditions",
                      leading: Icons.document_scanner_rounded,
                      action: () {
                        Navigator.of(context).pushNamed(TermsScreen.routeName);
                      },
                    ),
                    ListItem(
                      title: "Privacy Policy",
                      leading: Icons.privacy_tip_rounded,
                      action: () {
                        Navigator.of(context)
                            .pushNamed(PrivacyPolicyScreen.routeName);
                      },
                    ),
                    ListItem(
                      title: "Rate Us",
                      leading: Icons.star_sharp,
                      action: () => launchUrl(context,
                          "https://play.google.com/store/apps/details?id=com.ALO_Foodie_alo_foodie"),
                    ),
                    ListItem(
                      title: "Share App",
                      leading: Icons.share_rounded,
                      action: () => Share.share(
                        "Check out this amazing online delivery app. https://play.google.com/store/apps/details?id=com.ALO_Foodie_alo_foodie , Alofoodie delivers food and other products all over kanyakumari district at best price.",
                      ),
                    ),
                    ListItem(
                      title: "Log Out",
                      leading: Icons.logout_rounded,
                      action: () {
                        _showDialog(context, user);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(index: 4),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final IconData leading;
  final VoidCallback action;
  const ListItem({
    required this.title,
    required this.leading,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(leading),
      onTap: action,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
      ),
    );
  }
}

void launchUrl(BuildContext context, String url) async {
  await canLaunch(url)
      ? await launch(url)
      : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong when launching URL"),
          ),
        );
}
