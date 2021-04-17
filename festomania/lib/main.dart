import 'package:festomania/src/views/ui/LoadingPage.dart';
import 'package:festomania/src/views/ui/LoginPage.dart';
import 'package:festomania/src/views/ui/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MaterialApp(
    debugShowCheckedModeBanner: false,
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


      ),
      home: LoadingPage(),

    );
  }
}

