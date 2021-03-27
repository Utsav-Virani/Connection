import 'package:connection/config/auth.dart';
import 'package:connection/screens/Authentication/Authentication.dart';
import 'package:connection/screens/SignInScreen.dart';
import 'package:connection/screens/SignUpScreen.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.amber,
    backgroundColor: Color(0xff1E90FF),
    title: Center(
      child: Image(
        image: new AssetImage("lib/assets/connection_text.png"),
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
              MaterialPageRoute(builder: (context) => Authentication()));
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
    backgroundColor: Color(0xff1E90FF),
    title: Center(
      child: Image(
        image: new AssetImage("lib/assets/connection_text.png"),
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

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
