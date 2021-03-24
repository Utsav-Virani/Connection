import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/modal/CountrySelecter.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _countryNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _phoneCodeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          // Center(
          //   child: Image(
          //     image: new AssetImage("lib/assets/logo_trans.png"),
          //     fit: BoxFit.cover,
          //     height: MediaQuery.of(context).size.width * 0.7,
          //   ),
          // ),
          Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.39,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              // color: Colors.cyan,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.17),
                    blurRadius: 6.0,
                    spreadRadius: 3.0,
                    offset: Offset(
                      4.0,
                      4.0,
                    ),
                  ),
                ],
                border: Border.all(
                  width: 3,
                  color: Colors.black45,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: GestureDetector(
                        onTap: () async {
                          final selectedCountryData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountrySelecter()),
                          );
                        },
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          controller: _countryNameController,
                          decoration: InputDecoration(hintText: "India"),
                        ),
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
                              cursorColor: ColorPalette['swatch 15'],
                              decoration: InputDecoration(
                                hintText: "+91",
                                fillColor: ColorPalette['swatch 15'],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                  color: ColorPalette['swatch 15']
                                ),
                                focusColor: ColorPalette['swatch 15'],
                                hoverColor: ColorPalette['swatch 15'],
                                fillColor: ColorPalette['swatch 15'],
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
                        color: ColorPalette['swatch 6'],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        child: Container(
                          child: Text(
                            "Send OTP",
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
