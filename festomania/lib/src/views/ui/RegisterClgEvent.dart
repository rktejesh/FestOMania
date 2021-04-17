import 'package:flutter/material.dart';
import 'dart:ui';

class RegisterClgEvent extends StatefulWidget {
  @override
  _RegisterClgEventState createState() => _RegisterClgEventState();
}

class _RegisterClgEventState extends State<RegisterClgEvent> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff5c6bc0),
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Register your\nCollege Event ',
                                style: TextStyle(
                                  fontFamily: 'Alegreya',
                                  fontSize: 28,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 30, right: 20, top: 10, bottom: 10),
                                  labelText: 'Password',
                                  labelStyle:
                                  TextStyle(fontSize: 19, color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'College name',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Event name',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Category of event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Description of event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Registration link for event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Facebook post link of event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Instagram post link of event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                  labelText: 'Twitter post link of event',
                                  labelStyle: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 20, top: 20, right: 15, left: 15),
                            child: InkWell(
                              child: Text(
                                'Upload Poster',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
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
                                    ]
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20))),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'Alegreya',
                                      fontSize: 27,
                                      color: const Color(0xff1c69f0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}