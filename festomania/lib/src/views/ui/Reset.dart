
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(title: Text('Reset Password'),
      backgroundColor: const Color(0xff5c6bc0),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: const Color(0xff5c6bc0),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 30, right: 20, top: 20, bottom: 20),
                              labelText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: const Color(0xff5c6bc0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: const Color(0xff5c6bc0),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: const Color(0xff5c6bc0),
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: const Color(0xff5c6bc0),
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: const Color(0xff5c6bc0),
                                  )),
                              labelStyle:
                                  TextStyle(fontSize: 26, color: const Color(0xff5c6bc0) )),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: Text('Send Request',
                style: TextStyle(fontSize: 20, color: Colors.white),),
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);
                  Navigator.of(context).pop();
                  return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Reset Password"),
                  content: Text("An email has been sent to $_email please verify"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Okay"),
                    ),
                  ],
                ),
              );
                },
              ),

            ],
          ),

        ],),
    );
  }
}