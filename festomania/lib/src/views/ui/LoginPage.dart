import 'dart:ui';
import 'package:festomania/src/views/ui/LoadingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:festomania/src/views/ui/MainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool loading = false;

class _LoginPageState extends State<LoginPage> {
  String errorText;
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5c6bc0),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                            "lib/src/assets/images/loginpageGraphic.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Welcome\nback',
                    style: TextStyle(
                      fontFamily: 'Alegreya',
                      fontSize: 40,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        style: TextStyle(color: Colors.blue),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 30, right: 20, top: 20, bottom: 20),
                          labelText: 'Username/Email',
                        ),

                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 30, right: 15, left: 15),
                      child: TextField(
                        style: TextStyle(color: Colors.blue),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding:
                  const EdgeInsets.only(bottom: 30, right: 15, left: 15),
                  child: InkWell(
                    child: TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 20, color: Colors.white), ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoadingPage()),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
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
                            setState(() {
                              loading = true;
                            });
                            await auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => MainPageUpcoming()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              setState(() {
                                loading = false;
                                errorText = "The email specified does not exist.";
                                _showDialog();
                              });
                            } else if (e.code == 'wrong-password') {
                              loading = false;
                              errorText = "The password is incorrect.";
                              _showDialog();
                            } else if (e.code == 'user-not-found') {
                              loading = false;
                              errorText =
                              "This email is not registered or already has an account.";
                              _showDialog();
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: 10, bottom: 5, top: 5, right: 10)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                        ),
                        child: Text(
                          'Login',
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