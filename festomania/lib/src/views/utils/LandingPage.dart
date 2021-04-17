import 'package:festomania/src/views/ui/MainPage.dart';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:festomania/src/views/ui/ChoicePage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return ChoicePage();
          }
          return MainPageUpcoming();
        } else {
          return Scaffold(
            body: Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }
}