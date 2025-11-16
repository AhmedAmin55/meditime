import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

import '../../../../core/widgets/navbar.dart';
//
// class AuthUser {
//   FirebaseAuth auth = FirebaseAuth.instance;
// register user
//   void createUser(
//     BuildContext context, {
//     required String email,
//     required String password,
//     //  required SnackBar snackBar,
//   }) async {
//     try {
//      await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (ctx) => Navbar()),
//       );
//       print("user created => ${auth.currentUser!.email}");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "email-already-in-use") {
//         ScaffoldMessenger.of(context).showSnackBar(
//           warningSnackBar(context, AppTexts.emailAlreadyExist),
//         );
//       }else if(e.code=="weak-password"){
//         ScaffoldMessenger.of(context).showSnackBar(
//           warningSnackBar(context, AppTexts.weakPassword),
//         );
//       }else if(e.code == "network-request-failed" ){
//         ScaffoldMessenger.of(context).showSnackBar(
//           warningSnackBar(context, AppTexts.problemWithInternetConnection),
//         );
//       }else{
//         print(e.code);
//       }
//     }catch(e){
//       print(e);
//     }
//
//   }
// login user
//   Future<void> loginWithEmail(
//       BuildContext context, {
//         required String email,
//         required String password,
//       })async {
//     try{
//      await auth.signInWithEmailAndPassword(email: email, password: password);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (ctx) => Navbar()),
//       );
//     }on FirebaseAuthException catch (e) {
//       if ( e.code == "invalid-credential") {
//         ScaffoldMessenger.of(context).showSnackBar(
//             warningSnackBar(context, AppTexts.emailOrPasswordIncorrect),
//         );
//       }else if(e.code == "network-request-failed" ){
//         ScaffoldMessenger.of(context).showSnackBar(
//          warningSnackBar(context, AppTexts.problemWithInternetConnection),
//         );
//       }else{
//         print(e.code);
//       }
//     }catch(e){
//       print(e);
//     }
//   }
// }
//
// SnackBar warningSnackBar(BuildContext context, String warningMessage){
//   return SnackBar(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
//     ),
//     content: Text(
//       warningMessage,
//       style: AppTextsStyle.merriweatherRegular20(context),
//     ),
//     backgroundColor: AppColors.splashScreenColor,
//   );
// }