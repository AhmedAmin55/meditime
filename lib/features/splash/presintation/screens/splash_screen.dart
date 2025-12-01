// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/business_logic/nav_cubit/nav_cubit.dart';
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/navbar.dart';
import '../../../../main.dart';
import '../../../auth/presintation/screens/authentication_screen.dart';

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
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
    } else {
      context.read<UserCubit>().fetchUser(uid: user.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Navbar()),
      );

      if (shouldOpenNotificationsTab) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<NavCubit>().changeScreen(index: 3);
        });
        shouldOpenNotificationsTab = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(),
          Image.asset(AppImages.splashScreenLogo, width: width * 0.3),
          SizedBox(height: 10),
          Text(
            AppTexts.appName,
            style: AppTextsStyle.merriweatherBold30(context),
          ),
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
