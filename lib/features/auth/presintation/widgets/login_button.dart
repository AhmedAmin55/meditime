// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../business_logic/auth_switch_cubit/auth_switch_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<AuthSwitchCubit, AuthSwitchState>(
      builder: (context, state) {
        return Container(
          height: height * 0.070,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: state is AuthSwitchInitial
                ? BorderRadius.only(topRight: Radius.circular(8))
                : BorderRadius.only(topLeft: Radius.circular(8)),

            boxShadow: [
              BoxShadow(
                color: AppColors.white,
                spreadRadius: 5,
                offset: Offset(5, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.009,
                decoration: BoxDecoration(
                  borderRadius: state is AuthSwitchInitial
                      ? BorderRadius.only(topRight: Radius.circular(17))
                      : BorderRadius.only(topLeft: Radius.circular(17)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.waitingMedicineColor, AppColors.white],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                title,
                style: AppTextsStyle.merriweatherRegular20(
                  context,
                ).copyWith(color: AppColors.splashScreenColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
