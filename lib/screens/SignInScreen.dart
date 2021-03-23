import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/auth.dart';
import 'package:connection/config/database.dart';
import 'package:connection/data/dataCollection.dart';
import 'package:connection/modal/userData.dart';
import 'package:connection/screens/HomeView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  QuerySnapshot userInfo;

  AuthMethods _authMethod = AuthMethods();
  DataBaseMethods databaseMethods = new DataBaseMethods();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  userSignUp() async {
    final _auth = FirebaseAuth.instance;
    if (_formKey.currentState.validate()) {
      // DataStorage.setUserNamePreference(_userNameController.text);

      setState(() {
        isLoading = true;
      });

      try {
        // final authResult = await _authMethod.signInWithEmail(
        //     _emailController.text, _passwordController.text);
        UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        DataStorage.setUserEmailPreference(_emailController.text);

        databaseMethods
            .getUserNameByUserEmail(_emailController.text)
            .then((value) {
          userInfo = value;
          DataStorage.setUserNamePreference(userInfo.docs[0].data()['name']);
        });

        // print(UserData().userId);

        DataStorage.setUserSignInPreference(true);

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
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height - 50,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: new AssetImage("lib/assets/logo_trans.png"),
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      // SizedBox(height: 10,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
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
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                enableSuggestions: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Password:',
                                ),
                                validator: (val) {
                                  return val.length < 6
                                      ? "Enter Password 6+ characters"
                                      : null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
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
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ],
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account? ",
                            // style: simpleTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "Create one now",
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
