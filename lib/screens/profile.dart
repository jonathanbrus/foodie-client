import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../providers/auth.dart';

//screen
import 'auth/auth.dart';
// import './my_addresses.dart';
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
  Future<void> _showDialog(context, auth) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Are you sure?"),
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
            ),
          ),
          TextButton(
            onPressed: () {
              auth.signOut();
              // SystemNavigator.pop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AuthScreen.routeName,
                (route) => route.settings.name == AuthScreen.routeName,
              );
            },
            child: Text("Yes"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
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
                name: auth.userData.name,
                email: auth.userData.mailId,
                phone: auth.userData.phone,
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
                    ListItem(
                      title: "Edit Profile",
                      leading: Icons.edit_rounded,
                      action: () {},
                    ),
                    ListItem(
                      title: "Addresses",
                      leading: Icons.location_city_rounded,
                      action: () {},
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
                      action: () {
                        Navigator.of(context)
                            .pushNamed(PrivacyPolicyScreen.routeName);
                      },
                    ),
                    ListItem(
                      title: "Share App",
                      leading: Icons.share_rounded,
                      action: () => Share.share(
                        "Check out this amazing online food delivery app. https://play.google.com/store/apps/details?id=com.ALO_Foodie_alo_foodie",
                      ),
                    ),
                    ListItem(
                      title: "Log Out",
                      leading: Icons.logout_rounded,
                      action: () {
                        _showDialog(context, auth);
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
