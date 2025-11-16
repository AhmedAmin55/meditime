import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';

import '../../../../core/business_logic/nav_cubit/nav_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/navbar.dart';
import '../../../auth/presintation/screens/authentication_screen.dart';
import '../../data/services/check_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  List<Widget> indecators = [
    Container(
      width: 10.67,
      height: 10.67,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
    ),
    SizedBox(width: 16.33),
    Container(
      width: 10.67,
      height: 10.67,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
    ),
    SizedBox(width: 16.33),
    Container(
      width: 10.67,
      height: 10.67,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // optional splash delay
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // not signed in → go to SignIn

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
    } else {
      // signed in → go to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>
            Navbar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(),
          Image.asset(
              AppImages.splashScreenLogo, width: width * 0.3),
          SizedBox(height: 10),
          Text(
            AppTexts.appName, style: AppTextsStyle.merriweatherBold30(context),
          ),
          // AnimatedTextKit(
          //   repeatForever: true,
          //   animatedTexts: [
          //     ColorizeAnimatedText(
          //       AppTexts.appName,
          //       speed: Duration(milliseconds: 400),
          //       colors: [
          //         AppColors.white,
          //         AppColors.medicineBorderColor,
          //         AppColors.splashScreenColor,
          //       ],
          //       textStyle: AppTextsStyle.merriweatherBold30(context),
          //     ),
          //   ],
          //   pause: Duration(milliseconds: 1000),
          // ),
          SizedBox(height: 20),
          Text(
            "Never miss a dose again",
            style: AppTextsStyle.merriweatherRegular20(context),
          ),
          SizedBox(height: height * 0.30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indecators,
          ),
          SizedBox(height: 20),
          Text(
            "Loading your health companion",
            style: AppTextsStyle.merriweatherRegular20(context),
          ),
          SizedBox(height: height * 0.05),
        ],
      ),
    );
  }
}
