import 'dart:ui';
import 'package:festomania/src/views/ui/ChoicePage.dart';
import 'package:festomania/src/views/ui/Reset.dart';
import 'package:festomania/src/views/utils/LandingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5c6bc0),
      body: SafeArea(
        top: true,
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
                    width: 200,
                    height: 200,
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
                      fontSize: 36,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 30, right: 20, top: 10, bottom: 10),
                              labelText: 'Username/Email',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              labelStyle:
                              TextStyle(fontSize: 16, color: Colors.white)),
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(
                                errorText: "Not valid Email pattern"),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 5, right: 15, left: 15),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 30, right: 20, top: 10, bottom: 10),
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              labelStyle:
                              TextStyle(fontSize: 16, color: Colors.white)),
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
                            });
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding:
                  const EdgeInsets.only(bottom: 3, right: 15, left: 15),
                  child: InkWell(
                    child: TextButton(
                      child: Text('Forgot Password?',
                        style: TextStyle(fontSize: 15, color: Colors.white),),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResetScreen()),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 75, right: 75),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LandingPage()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              setState(() {
                                loading = false;
                                errorText="The email specified does not exist.";
                                _showDialog();
                              });
                            }
                            else if (e.code == 'wrong-password') {
                              loading = false;
                              errorText = "The password is incorrect.";
                              _showDialog();
                            }
                            else if (e.code == 'user-not-found') {
                              loading = false;
                              errorText = "This email is not registered or already has an account.";
                              _showDialog();
                            }
                            else {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: 40,right: 40)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Alegreya',
                            fontSize: 28,
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
