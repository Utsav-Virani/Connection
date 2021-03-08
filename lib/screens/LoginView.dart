import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // String countryCode = '+91';

  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _phone = {"dialCode": "", "dialNum": ""};
  // TextEditingController _countryCodeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _countryCodeController = TextEditingController(text: '+91');
  }

  Future<http.Response> sendDataToBack() async {
    final response = await http.put(
      Uri.http('192.168.0.137:4000', 'createUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_phone),
    );
    print(response.body);
  }

  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      sendDataToBack();
    }
  }

  // fatchData() async {

  //     return http.get(Uri.http('http://192.168.0.137:4000','/'));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: new AssetImage("lib/assets/logo_trans.png"),
          fit: BoxFit.cover,
          height: 300,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: IntlPhoneField(
                  initialCountryCode: "IN",
                  autoValidate: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                  ],
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                  ),
                  // onChanged: (phone) {
                  //   print(phone.countryCode);
                  //   print(phone.number);
                  // },
                  onChanged: (phone) {
                    _phone['dialCode'] = phone.countryCode;
                    _phone['dialNum'] = phone.number;
                  },
                ),
              ),
              //     // SizedBox(
              //     //   width: MediaQuery.of(context).size.width * 0.6,
              //     //   child: TextFormField(
              //     //     textAlign: TextAlign.center,
              //     //     decoration: InputDecoration(
              //     //       hintText: "Country Name",
              //     //     ),
              //     //   ),
              //     // ),
              //     //Padding(padding: EdgeInsets.only(top: 15)),
              //     // Row(
              //     //   crossAxisAlignment: CrossAxisAlignment.center,
              //     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //   children: [
              //     //     SizedBox(
              //     //       width: MediaQuery.of(context).size.width * 0.18,
              //     //       child: TextFormField(
              //     //         textAlign: TextAlign.center,
              //     //         // initialValue: countryCode,
              //     //         controller: _countryCodeController,
              //     //         maxLength: 4,
              //     //         // decoration: InputDecoration(
              //     //         //   hintText: countryCode,
              //     //         // ),
              //     //         enabled: false,
              //     //       ),
              //     //     ),
              //     //     // Padding(padding: EdgeInsets.only(right: 15)),
              //     //     SizedBox(
              //     //       width: MediaQuery.of(context).size.width * 0.60,
              //     //       child: TextFormField(
              //     //         keyboardType:
              //     //             TextInputType.numberWithOptions(decimal: true),
              //     //         inputFormatters: [
              //     //           FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              //     //         ],
              //     //         maxLength: 10,
              //     //         decoration: InputDecoration(hintText: "Mobile Number"),
              //     //         onChanged: (value) => print(value),
              //     //       ),
              //     //     ),
              //     //   ],
              //     // ),
              Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(
                width: 120,
                child: OutlineButton(
                  onPressed: _saveForm,
                  child: Text("Send OTP"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
