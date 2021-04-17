import 'package:festomania/src/views/ui/ChoicePage.dart';
import 'package:flutter/material.dart';
import 'package:festomania/src/views/ui/CtfEvent.dart';
import 'package:festomania/src/views/ui/RegisterClgEvent.dart';
import 'package:festomania/src/views/ui/CodingEvent.dart';
import 'package:festomania/src/views/ui/Hackathon.dart';
import 'package:festomania/src/views/ui/TechnicalTalks.dart';
import 'package:festomania/src/views/ui/AboutUs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    try {
      loading = false;
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      loading = false;
    }
  }
  String _user = FirebaseAuth.instance.currentUser.displayName;
  String _userEmail = FirebaseAuth.instance.currentUser.email;
  bool _userStringEmpty = true;
  bool _userPhotoUrlEmpty = true;
  bool _userEmailEmpty = true;

  Future<void> _usernameDefined() async {
    if(_user==null)
      _userStringEmpty = true;
    else
      _userStringEmpty = false;
  }
  Future<void> _userPhotoDefined() async {
    if(auth.currentUser.photoURL==null)
      _userPhotoUrlEmpty = true;
    else
      _userPhotoUrlEmpty = false;
  }
  Future<void> _userEmailDefined() async {
    if(_userEmail==null)
      _userEmailEmpty = true;
    else
      _userEmailEmpty = false;
  }

  @override
  void initState() {
    _usernameDefined();
    _userPhotoDefined();
    _userEmailDefined();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: _userPhotoUrlEmpty ? AssetImage("lib/src/assets/images/blank-profile-picture.png") : NetworkImage(auth.currentUser.photoURL),
            ),
            accountName: _userStringEmpty ? Text("  "):Text(_user),
            decoration: BoxDecoration(),
            accountEmail: _userEmailEmpty ? Text("  "):Text(_userEmail),
          ),
          ListTile(
            title: Text('Coding Events'),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodingEventPage(),));
            },
          ),
          ListTile(
            title: Text('Hackathons'),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HackathonsPage(),));
            },
          ),
          ListTile(
            title: Text('Ctf Events'),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CtfEventPage(),));
            },
          ),
          ListTile(
            title: Text('Technical Talks'),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TechnicalTalk(),));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Register Your College'),
            onTap:() {
             Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterClgEvent(),));
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap:() {
             Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUs(),));
            },
          ),
          ListTile(
            title: Text('Signout'),
            onTap: _signOut,
          ),
          Divider(),
        ],
      ),
    );
  }
}

