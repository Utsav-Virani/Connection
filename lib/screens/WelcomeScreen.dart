import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/screens/Authentication/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette['swatch_20'],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: SvgPicture.asset(
                'lib/assets/Connection.svg',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authentication(),
                  ),
                );
              },
              // alignment: Alignment.bottomCenter,
              // margin: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "This way to SignIn",
                    style: TextStyle(
                      color: ColorPalette['swatch_15'],
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorPalette['swatch_15'],
                    size: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
