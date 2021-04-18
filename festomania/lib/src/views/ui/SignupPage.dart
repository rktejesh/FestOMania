import 'dart:async';
import 'dart:ui';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
      await DatabaseService(uid: user.uid).updateUserData(user.displayName, user.email,user.uid,null);
      timer.cancel();
    }
  }

  bool loading = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _username = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: const Color(0xff5c6bc0),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  "lib/src/assets/images/signuppagegraphic.png"),
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
                            fontSize: 36,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 30, right: 20, top: 10, bottom: 10),
                          labelText: 'Username',
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
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          labelStyle: TextStyle(
                              fontSize: 16, color: Colors.white)),
                      onChanged: (value) {
                        setState(() {
                          _username = value.trim();
                        });
                      },
                      validator: RequiredValidator(errorText: "Required"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 30, right: 20, top: 10, bottom: 10),
                          labelText: 'Email',
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
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          labelStyle: TextStyle(
                              fontSize: 16, color: Colors.white)),
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
                    padding: const EdgeInsets.all(23),
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
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          labelStyle: TextStyle(
                              fontSize: 16, color: Colors.white)),
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(8,
                            errorText:
                            "Password must be a minimum length of 8 "),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 30, right: 20, top: 10, bottom: 10),
                          labelText: 'Confirm Password',
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
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          labelStyle: TextStyle(
                              fontSize: 16, color: Colors.white)),
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value.trim();
                        });
                      },
                      //validator MultiValidator([
                      //RequiredValidator(errorText: "Required"),
                      validator: (_confirmPassword) => MatchValidator(
                          errorText: "Password did not matched!")
                          .validateMatch(_password, _confirmPassword),
                    ),
                    //])
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 25, bottom: 20, left: 75, right: 75),
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
                              }else {
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
                                    BorderRadius.circular(15))),
                          ),
                          child: Text(
                            'Signup',
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
      ),
    );
  }
}

