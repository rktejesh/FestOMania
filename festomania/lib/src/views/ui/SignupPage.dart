import 'dart:async';
import 'dart:ui';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:festomania/src/views/utils/database.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String errorText = "";

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
              child: AlertDialog(
                content: Text(errorText),
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6));
        });
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    user.updateProfile(displayName: _username);
    await user.reload();
    if (user.emailVerified) {
      await DatabaseService(uid: user.uid).updateUserData(
          user.displayName, user.email, user.uid, null);
      timer.cancel();
    }
  }

  bool loading = false;

  String _username = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: const Color(0xff5c6bc0) ,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Singup',
                    textAlign: TextAlign.left,
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage(
                                "lib/src/assests/images/signuppagegraphic.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 40,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: TextField(
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Username',),
                      onChanged: (value) {
                        setState(() {
                          _username = value.trim();
                        });
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: TextField(
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',),
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(23),
                  child: TextField(
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',),
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(23),
                  child: TextField(
                      style: TextStyle(color: Colors.blue),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',),
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value.trim();
                        });
                      }

                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 25, bottom: 20, left: 60, right: 60),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(17, 17, 26, 0.1),
                              offset: Offset(0, 0),
                              blurRadius: 16,
                            )
                          ]),
                      child: TextButton(
                        onPressed: () async {
                          try {
                            await auth.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );
                            user = auth.currentUser;
                            user.sendEmailVerification();
                            checkEmailVerified();
                            timer = Timer.periodic(Duration(seconds: 5),
                                    (timer) {
                                  checkEmailVerified();
                                });
                            errorText =
                            "An Email has been sent to $_email please verify";
                            _showDialog();
                          } on FirebaseAuthException catch (e) {
                            if (e.code ==
                                'email-already-in-use') {
                              loading = false;
                              errorText =
                              "An account already exists with this email.";
                              _showDialog();
                            } else if (e.code ==
                                'invalid-email') {
                              loading = false;
                              errorText =
                              "The specified email is invalid";
                              _showDialog();
                            } else if (e.code ==
                                'operation-not-allowed') {
                              loading = false;
                              errorText =
                              "Invalid Input.";
                              _showDialog();
                            } else {
                              loading = false;
                              errorText =
                              "Error: Please try again";
                              _showDialog();
                            }
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                  top: 5,
                                  right: 10)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25))),
                        ),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            fontFamily: 'Alegreya',
                            fontSize: 35,
                            color: const Color(0xff1c69f0),
                          ),
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
    );
  }
}