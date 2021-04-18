import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:path/path.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:festomania/src/views/utils/LandingPage.dart';
import 'package:festomania/src/views/utils/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterClgEvent extends StatefulWidget {
  @override
  _RegisterClgEventState createState() => _RegisterClgEventState();
}


class _RegisterClgEventState extends State<RegisterClgEvent> {
  String errorText;
  _showDialog() {
    print(errorText);
  }
  final format = DateFormat("yyyy-MM-dd at HH:mm");
  String imageUrl;
  String dropdownValue = 'Hackathon';
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    await Permission.photos.request();
    PickedFile image;
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted){
      image = await ImagePicker().getImage(source: ImageSource.gallery);
      File file = File(image.path);
      String filename = basename(image.path);
      if (image != null){
        try {
          await _firebaseStorage
              .ref('Events/$_collegeName _$filename')
              .putFile(file);
          String downloadURL = await FirebaseStorage.instance.ref('Events/$_collegeName _$filename').getDownloadURL();
          setState(() {
            imageUrl = downloadURL;
          });
        } on FirebaseException catch (e) {
          print(e.toString());
        }
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _eMail = "";
  String _password = "";
  String _collegeName = "";
  String _eventName = "";
  String _eventCategory = "";
  String _description = "";
  String _registrationLink = "";
  String _facebookLink = "";
  String _instagramLink = "";
  String _twitterLink = "";
  DateTime date1;
  DateTime date2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff5c6bc0),
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child : Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: formKey,

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _eMail = value.trim();
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
                                padding: const EdgeInsets.all(20.0),
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'College name',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _collegeName = value.trim();
                                    });
                                  },
                                  validator: RequiredValidator(errorText: "Required"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Event name',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _eventName = value.trim();
                                    });
                                  },
                                  validator: RequiredValidator(errorText: "Required"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: DateTimeField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Event Start Time',
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
                                      labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2020),
                                        initialDate: currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime:
                                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                      );
                                      date1 = DateTimeField.combine(date, time);
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      date1 = currentValue;
                                      return currentValue;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: DateTimeField (
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 30, right: 20, top: 10, bottom: 10),
                                      labelText: 'Event End Time',
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

                                      labelStyle:
                                      TextStyle(fontSize: 16, color: Colors.white)),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2020),
                                        initialDate: currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime:
                                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                      );
                                      date2 = DateTimeField.combine(date, time);
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      date2 = currentValue;
                                      return currentValue;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:20.0,left: 30),
                                      child: DropdownButton<String>(
                                        iconDisabledColor: Colors.black,
                                        isExpanded: true,
                                        dropdownColor: const Color(0xff5c6bc0),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Alegreya'
                                        ),
                                        value: dropdownValue,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>['Hackathon', 'CTF Events', 'Technical Talks', 'Coding Events', 'Technical Talk Collection', 'Technical Talk Live']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(color: Colors.white)
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Description of event',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _description = value.trim();
                                    });
                                  },
                                  validator: RequiredValidator(errorText: "Required"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Registration link for event',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _registrationLink = value.trim();
                                    });
                                  },
                                  validator: RequiredValidator(errorText: "Required"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Facebook post link of event',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _facebookLink = value.trim();
                                    });
                                  },

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Instagram post link of event',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _instagramLink = value.trim();
                                    });
                                  },

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 30 , right: 20, top: 10, bottom: 10),
                                      labelText: 'Twitter post link of event',
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
                                          fontSize: 16,
                                          color: Colors.white
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _twitterLink = value.trim();
                                    });
                                  },

                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(2, 2),
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: (imageUrl != null)
                                      ? Image.network(imageUrl)
                                      : Text("Image has not been uploaded.")
                              ),
                              ElevatedButton(
                                child: Text("Upload Image"),
                                onPressed: (){
                                  uploadImage();
                                },
                              ),

                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10, left: 75, right: 75),
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
                                        ]
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        try {
                                          setState(() {
                                          });
                                          await auth.signInWithEmailAndPassword(email: _eMail, password: _password);
                                          DateTime.now().isAfter(date1) ? _eventCategory = "Live" : _eventCategory = "Upcoming";
                                          EventDatabaseService().updateEventData(imageUrl, _eventName, _collegeName, dropdownValue ,_eventCategory, _description, date1, date2, _registrationLink, _facebookLink, _instagramLink, _twitterLink);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) => LandingPage()));
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'invalid-email') {
                                            setState(() {
                                              errorText="The email specified does not exist.";
                                              _showDialog();
                                            });
                                          }
                                          else if (e.code == 'wrong-password') {
                                            errorText = "The password is incorrect.";
                                            _showDialog();
                                          }
                                          else if (e.code == 'user-not-found') {
                                            errorText = "The email or password is incorrect.";
                                            _showDialog();
                                          }
                                          else {
                                            setState(() {
                                            });
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(Colors.white),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15))),
                                      ),
                                      child: Text(
                                        'Register',
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
                            ]
                        )
                    )
                )
            )
        )
    );
  }
}