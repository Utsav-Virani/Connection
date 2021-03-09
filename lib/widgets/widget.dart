import 'package:flutter/material.dart';
import 'package:connection/screens/SignInView.dart';
import 'package:connection/screens/SignUpView.dart';
import 'package:connection/config/auth.dart';

Widget appBar(BuildContext context){
  return AppBar(
    title:  Text("Connection"),
    actions: [
      GestureDetector(
        onTap: () {
          // AuthMethods().signOut();
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => Authenticate()));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app)),
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