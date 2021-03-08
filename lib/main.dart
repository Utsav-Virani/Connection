import 'package:connection/screens/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Connection",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: Scaffold(
        body: HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 25,
              right: 25),
        ),
        LoginView(),

        // Padding(
        //   padding: EdgeInsets.only(left: 25, right: 25),
        //   child: LoginView(),
        // )
      ],
    );
  }
}
