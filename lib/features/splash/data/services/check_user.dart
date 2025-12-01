// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import '../../../auth/presintation/screens/authentication_screen.dart';
import '../../../home/presintation/screens/home_screen.dart';

class CheckUser {
  User? user = FirebaseAuth.instance.currentUser;

  userChecker(BuildContext context) async {
    if (user == null) {
      print("=========================>>>>>>> user is null");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => AuthenticationScreen()),
      );
    } else {
      print("user is not null");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => HomeScreen()),
      );
    }
  }
}























