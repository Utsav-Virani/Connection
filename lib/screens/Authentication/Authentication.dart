import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/modal/CountrySelecter.dart';
import 'package:connection/screens/Authentication/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _countryNameController =
      new TextEditingController(text: "India");
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _phoneCodeController =
      new TextEditingController(text: "+91");

  @override
  void dispose() {
    _countryNameController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "OTP Verification",
            style: TextStyle(
              fontSize: 30,
              color: ColorPalette['swatch_25'],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: ColorPalette['swatch_1'],
        elevation: 2,
      ),
      backgroundColor: ColorPalette['swatch_1'],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(
                "We'll send you an OTP.",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPalette['swatch_25'],
                ),
              ),
            ),
          ),
          Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.39,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              // color: Colors.cyan,
              decoration: BoxDecoration(
                color: Colors.white,
                // color: ColorPalette['swatch_20'],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.2),
                    blurRadius: 6.0,
                    spreadRadius: 3.0,
                    offset: Offset(
                      4.0,
                      4.0,
                    ),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final dynamic selectedCountryData =
                              await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountrySelecter()),
                          );
                          _countryNameController.text =
                              selectedCountryData['name'];
                          _phoneCodeController.text =
                              selectedCountryData['code'];
                        },
                        textAlign: TextAlign.center,
                        // enabled: false,
                        controller: _countryNameController,
                        // decoration: InputDecoration(),
                      ),
                    ),
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              controller: _phoneCodeController,
                              cursorColor: ColorPalette['swatch_15'],
                              decoration: InputDecoration(
                                hintText: "+91",
                                fillColor: ColorPalette['swatch_15'],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (mobilenum) {
                                  return RegExp(r"^[6-9]\d{9}$")
                                          .hasMatch(mobilenum)
                                      ? null
                                      : "Invalid Mobile Number";
                                },
                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(
                                      color: ColorPalette['swatch_15']),
                                  focusColor: ColorPalette['swatch_15'],
                                  hoverColor: ColorPalette['swatch_15'],
                                  fillColor: ColorPalette['swatch_15'],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: ColorPalette['swatch_20'],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                      _phoneCodeController.text +
                                          _phoneNumberController.text)),
                            );
                          }
                        },
                        child: Container(
                          child: Text(
                            "Send OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
