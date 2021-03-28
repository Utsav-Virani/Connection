import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/screens/Authentication/Credentials.dart';
import 'package:connection/screens/HomeView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  OtpScreen(this.phoneNumber);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String verificationCode;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: ColorPalette['swatch_20'].withOpacity(0.3),
      border: Border.all(
        color: ColorPalette['swatch_20'],
        width: 2.5,
      ),
      borderRadius: BorderRadius.circular(18.0),
    );
  }

  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Credentials(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        print('----------');
        print(error.message);
        print('==========');
      },
      codeSent: (String verificationId, int resendToken) {
        print('----------sent----------');

        setState(() {
          verificationCode = verificationId;
        });
        print('==========sent==========');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('----------timeout----------');

        setState(() {
          verificationCode = verificationId;
        });
        print('==========timeout==========');
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter Verification Code",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        elevation: 0,
        backgroundColor: ColorPalette['swatch_20'],
      ),
      backgroundColor: ColorPalette['swatch_20'],
      key: _scaffoldKey,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.39,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // color: ColorPalette['swatch_20'],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: ColorPalette['swatch_20'],
                  child: Column(
                    children: [
                      Text(
                        "We have sent OTP on your number",
                        style: TextStyle(
                          fontSize: 20,
                          // color: ColorPalette['swatch_20'],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                          // width: 10,
                          ),
                      Text(
                        // widget.phoneNumber.length.toString(),
                        widget.phoneNumber.replaceRange(
                            widget.phoneNumber.length - 10,
                            widget.phoneNumber.length - 4,
                            "******"),
                        style: TextStyle(
                          fontSize: 18,
                          // color: ColorPalette['swatch_20'],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  // color: Colors.white,
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: PinPut(
                    fieldsCount: 6,
                    onSubmit: (pin) async {
                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        // ConfirmationResult confirmationResult =
                        //     await auth.signInWithPhoneNumber(
                        //         widget.phoneNumber,
                        //         RecaptchaVerifier(
                        //           container: 'recaptcha',
                        //           size: RecaptchaVerifierSize.compact,
                        //           theme: RecaptchaVerifierTheme.dark,
                        //         ));
                        // UserCredential userCredential =
                        //     await confirmationResult.confirm(pin);

                        await FirebaseAuth.instance
                            .signInWithCredential(
                          PhoneAuthProvider.credential(
                            verificationId: verificationCode,
                            smsCode: pin,
                          ),
                        )
                            .then((value) {
                          if (value != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Credentials(),
                              ),
                            );
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid OTP")));
                      }
                    },
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: ColorPalette['swatch_20'].withOpacity(.7),
                          width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
