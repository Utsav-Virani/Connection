import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/screens/Authentication/Authentication.dart';
import 'package:connection/screens/HomeView.dart';
import 'package:connection/screens/WelcomeScreen.dart';
import 'package:connection/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Connection",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        // primarySwatch: MaterialColor(
        //   0xFF399c7d,
        //   <int, Color>{
        //     100: ColorPalette['swatch_4'],
        //   },
        // ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapsort) {
          if (userSnapsort.hasData) {
            return HomeView();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
