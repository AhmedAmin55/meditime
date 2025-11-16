import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/auth/presintation/widgets/signup_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../business_logic/auth_switch_cubit/auth_switch_cubit.dart';
import 'login_button.dart';


class AuthenticationScreenHeader extends StatefulWidget {
  const AuthenticationScreenHeader({super.key});

  @override
  State<AuthenticationScreenHeader> createState() =>
      _AuthenticationScreenHeaderState();
}

class _AuthenticationScreenHeaderState
    extends State<AuthenticationScreenHeader> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.splashScreenColor,
      child: BlocBuilder<AuthSwitchCubit, AuthSwitchState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppImages.splashScreenLogo,
                width: state is AuthSwitchInitial ? width * 0.3 : width * 0.2,
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthSwitchCubit>().showLogin();
                      },
                      child: state is AuthSwitchInitial
                          ? LoginButton(title: AppTexts.login,)
                          : SignupButton(title: AppTexts.login,),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthSwitchCubit>().showSignUp();
                      },
                      child: state is AuthSignUpState
                          ? LoginButton(title: AppTexts.signup,)
                          : SignupButton(title: AppTexts.signup,),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
