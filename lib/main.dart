import 'package:flutter/material.dart';

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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: new AssetImage("lib/assets/logo_trans.png"),
                fit: BoxFit.cover,
                height: 300,
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Mobile Number'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
