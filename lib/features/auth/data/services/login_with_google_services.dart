// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Project imports:
import '../../../../core/widgets/navbar.dart';

class GoogleAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  loginWithGoogle(BuildContext context) async {
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => Navbar()),
      );
    } on FirebaseAuthException catch (e) {
      print("====================>" + e.code);
    }
  }
}
