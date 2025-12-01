// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import 'package:meditime/features/profile/presintation/widgets/change_profile_name_dialog.dart';
import 'package:meditime/features/profile/presintation/widgets/container_do_some_thing.dart';
import 'package:meditime/features/profile/presintation/widgets/user_image.dart';
import '../../../../core/business_logic/nav_cubit/nav_cubit.dart';
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../auth/presintation/screens/authentication_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

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
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                print(state);
                if (state is UserLoaded) {
                  print("=====================================> ${state}");
                  return Text(
                    state.user.name,
                    style: AppTextsStyle.merriweatherBold30(context).copyWith(
                      color: AppColors.splashScreenColor.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            SizedBox(height: 4),
            Text(
              (BlocProvider.of<UserCubit>(context).state as UserLoaded)
                  .user
                  .email,
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return ChangeProfileNameDialog(
                                nameController: _nameController,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      ContainerDoSomeThing(
                        title: AppTexts.resetPassword,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return ChangeProfileNameDialog(
                                nameController: _nameController,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      ContainerDoSomeThing(
                        title: AppTexts.signOut,
                        onTap: () async {
                          await auth.signOut();
                          context.read<UserCubit>().resetUser();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AuthenticationScreen(),
                            ),
                            (route) => false,
                          );
                          context.read<NavCubit>().changeScreen(index: 0);
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
