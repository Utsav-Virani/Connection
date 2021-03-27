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
      border: Border.all(color: Colors.deepPurpleAccent),
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
                context, MaterialPageRoute(builder: (context) => HomeView()));
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
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.phoneNumber,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 90,
              // color: Colors.white,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              child: PinPut(
                fieldsCount: 5,
                onSubmit: (pin) async {
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    ConfirmationResult confirmationResult =
                        await auth.signInWithPhoneNumber(
                            widget.phoneNumber,
                            RecaptchaVerifier(
                              container: 'recaptcha',
                              size: RecaptchaVerifierSize.compact,
                              theme: RecaptchaVerifierTheme.dark,
                            ));
                    UserCredential userCredential =
                        await confirmationResult.confirm(pin);

                    // await FirebaseAuth.instance.signInWithCredential(
                    //     PhoneAuthProvider.credential(
                    //         verificationId: verificationCode, smsCode: pin),RecaptchaVerifier());
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Invalid OTP")));
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
                    color: Colors.deepPurpleAccent.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
