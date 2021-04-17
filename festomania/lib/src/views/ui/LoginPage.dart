import 'dart:ui';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    style: TextStyle(color: Colors.blue),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

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
            Text('Forgot Password?',
              style: TextStyle(fontSize: 20, color: Colors.blue),),
            Padding(
              padding: EdgeInsets.only(
                  top: 20, bottom: 20, left: 60, right: 60),
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
                            builder: (context) => MainPage()));
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

                child: Text(
                  'Login',

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
