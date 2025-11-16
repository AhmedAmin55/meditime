import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import 'package:meditime/features/profile/presintation/widgets/container_do_some_thing.dart';
import 'package:meditime/features/profile/presintation/widgets/user_image.dart';

import '../../../auth/presintation/screens/authentication_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            UserImage(),
            SizedBox(height: 12),
            Text(
              'ahmed amin basha',
              style: AppTextsStyle.merriweatherBold30(context).copyWith(
                color: AppColors.splashScreenColor.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'ahmed amin @gmail.com',
              style: AppTextsStyle.merriweatherRegular20(
                context,
              ).copyWith(color: AppColors.splashScreenColor.withOpacity(0.77)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: width,
                color: AppColors.scaffoldColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    children: [
                      ContainerDoSomeThing(
                        title: AppTexts.changeProfileName,
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
                      ContainerDoSomeThing(
                        title: AppTexts.resetPassword,
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
                      ContainerDoSomeThing(
                        title: AppTexts.signOut,
                        onTap: () async {
                          await auth.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AuthenticationScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
