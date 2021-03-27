import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/auth.dart';
import 'package:connection/config/database.dart';
import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/data/dataCollection.dart';
import 'package:connection/screens/HomeView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Credentials extends StatefulWidget {
  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final _formKey = GlobalKey<FormState>();
  QuerySnapshot userInfo;

  AuthMethods _authMethod = AuthMethods();
  DataBaseMethods databaseMethods = new DataBaseMethods();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  userSignUp() async {
    Map<String, String> userData = {
      "name": _userNameController.text,
      "email": _emailController.text,
    };

    try {
      // User authResult = await _authMethod.signUpWithEmail(
      // _emailController.text, .text);
      // print("-----");
      // print(authResult.uid);
      // print("-----");

      databaseMethods.uploadUserInfo(
          userData, FirebaseAuth.instance.currentUser.uid);

      DataStorage.setUserSignInPreference(true);
      DataStorage.setUserEmailPreference(_emailController.text);
      DataStorage.setUserNamePreference(_userNameController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      var errorMsg = "Invalid Credentials. Please enter valid information.";
      if (e.message != null) {
        errorMsg = e.message;
      }
      setState(() {
        // isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMsg)));
    }
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.39,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // color: Colors.amber,
          width: MediaQuery.of(context).size.height,
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
            // color: Colors.amberAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          validator: (value) {
                            return value.isEmpty || value.length < 3
                                ? "Invalid UserName"
                                : null;
                          },
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'User ID:',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorPalette['swatch_15'],
                            )),
                            focusedBorder: UnderlineInputBorder(
                              // borderRadius:
                              //     BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: ColorPalette['swatch_15'],
                                width: 2,
                              ),
                            ),
                            focusColor: ColorPalette['swatch_15'],
                          ),
                          cursorColor: ColorPalette['swatch_15'],
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "Enter correct email";
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email ID:',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorPalette['swatch_15'],
                            )),
                            focusedBorder: UnderlineInputBorder(
                              // borderRadius:
                              //     BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: ColorPalette['swatch_15'],
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    userSignUp();
                  },
                  child: Container(
                    // onPressed: _saveForm,
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPalette['swatch_17'],
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff2A75BC).withOpacity(0.2),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            4.0,
                            4.0,
                          ),
                        ),
                      ],
                      // gradient: LinearGradient(
                      //   colors: [
                      //     ColorPalette['swatch_5'],
                      //   ],
                      // ),
                    ),
                    child: Text(
                      "Go To Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
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
