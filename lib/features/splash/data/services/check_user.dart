import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

// userChecker(BuildContext context) {
//   return StreamBuilder(
//     stream: auth.authStateChanges(), builder: (context, snapshot) {
//     // 1. حالة الاتصال (Connection State)
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       // عرض شاشة تحميل أثناء التحقق من المستخدم لأول مرة
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     // 2. حالة المستخدم (Data State)
//     if (snapshot.hasData && snapshot.data != null) {
//       // المستخدم مسجل الدخول
//       return const HomeScreen();
//     } else {
//       // المستخدم غير مسجل الدخول (أو قيمة null مستقرة)
//       return const AuthenticationScreen();
//     }
//   },
//   );
// }
