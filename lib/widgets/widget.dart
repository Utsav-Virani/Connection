import 'package:connection/config/auth.dart';
import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/screens/Authentication/Authentication.dart';
import 'package:connection/screens/Authentication/Credentials.dart';
import 'package:connection/screens/HomeView.dart';
import 'package:connection/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.amber,
    backgroundColor: ColorPalette['swatch_20'],
    title: Center(
      child: Image(
        image: new AssetImage("lib/assets/app_logo_text.png"),
        // fit: BoxFit.cover,
        height: 200,
      ),
    ),
    elevation: 0.0,
    actions: [
      GestureDetector(
        onTap: () {
          AuthMethods().signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app)),
      )
    ],
  );
}

Widget SearchScreenAppBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.amber,
    backgroundColor: ColorPalette['swatch_20'],
    title: Center(
      child: Image(
        image: new AssetImage("lib/assets/app_logo_text.png"),
        // fit: BoxFit.cover,
        height: 200,
      ),
    ),
    elevation: 0.0,
    actions: [
      GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          // child: Icon(Icons.exit_to_app)
        ),
      )
    ],
  );
}

class UserCredentialsCheck extends StatefulWidget {
  @override
  _UserCredentialsCheckState createState() => _UserCredentialsCheckState();
}

class _UserCredentialsCheckState extends State<UserCredentialsCheck> {
  bool showSignIn = FirebaseAuth.instance.currentUser.displayName.isEmpty;
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Credentials();
    } else {
      return HomeView();
    }
  }
}
