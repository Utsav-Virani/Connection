import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: new AssetImage("lib/assets/logo_trans.png"),
            fit: BoxFit.cover,
            height: 300,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Mobile Number'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                // InternationalPhoneNumberInput(
                //   // onInputChanged: ,
                //   inputDecoration: InputDecoration(hintText: "Mobile NUmber"),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: OutlineButton(
                    onPressed: () {},
                    child: Text("Send OTP"),
                    hoverColor: Colors.blueAccent[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
