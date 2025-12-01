// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// Project imports:
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../../../../core/widgets/navbar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../business_logic/login_cubit/login_cubit.dart';
import '../../data/services/login_with_google_services.dart';
import 'custom_login_with.dart';
import 'login_or_signup_with.dart';

class Loginscreenbody extends StatefulWidget {
  const Loginscreenbody({super.key});

  @override
  State<Loginscreenbody> createState() => _LoginscreenbodyState();
}

class _LoginscreenbodyState extends State<Loginscreenbody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          context.read<UserCubit>().fetchUser(uid: state.user.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => Navbar()),
          );
        } else if (state is LoginFailure) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              content: Text(
                state.errorMessage,
                style: AppTextsStyle.merriweatherRegular20(context),
              ),
              backgroundColor: AppColors.splashScreenColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(
                  top: height * 0.04,
                  left: 30,
                  right: 30,
                ),
                children: [
                  Text(
                    AppTexts.welcomeBack,
                    style: AppTextsStyle.merriweatherBold30(
                      context,
                    ).copyWith(color: AppColors.splashScreenColor),
                  ),
                  Text(
                    AppTexts.loginInToManageYourMedications,
                    style: AppTextsStyle.merriweatherRegular20(context)
                        .copyWith(
                          color: AppColors.splashScreenColor.withOpacity(0.7),
                        ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    AppTexts.emailAddress,
                    style: AppTextsStyle.merriweatherRegular20(
                      context,
                    ).copyWith(color: AppColors.black.withOpacity(0.5)),
                  ),
                  SizedBox(height: 5),
                  CustomTextformfield(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppImages.emailIocn,
                    hintText: AppTexts.enterYourEmail,
                    controller: _emailController,
                    validator: (value) => value!.trim().validateEmail(),
                    hintTextStyle: AppTextsStyle.montserratRegular18(context),
                  ),
                  SizedBox(height: 15),
                  Text(
                    AppTexts.password,
                    style: AppTextsStyle.merriweatherRegular20(
                      context,
                    ).copyWith(color: AppColors.black.withOpacity(0.5)),
                  ),
                  SizedBox(height: 5),
                  CustomTextformfield(
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: AppImages.passIcon,
                    hintText: AppTexts.enterYourPassword,
                    controller: _passwordController,
                    obscureText: true,
                    visibleSuffixIcon: AppImages.visibleIcon,
                    inVisibleSuffixIcon: AppImages.inVisibleIcon,
                    validator: (value) => value!.trim().validatePassword(),
                    hintTextStyle: AppTextsStyle.montserratRegular18(context),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppTexts.forgotPassword,
                      style: AppTextsStyle.merriweatherRegular20(
                        context,
                      ).copyWith(color: AppColors.black.withOpacity(0.5)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: PrimaryButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).loginWithEmail(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      color: AppColors.splashScreenColor,
                      width: width * 0.77,
                      title: AppTexts.signIn,
                      height: height * 0.048,
                    ),
                  ),
                  SizedBox(height: 20),
                  LoginOrSignupWith(loginOrSignup: AppTexts.orLoginWith),
                  Flexible(child: SizedBox(height: 30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomAuthWith(
                        icon: AppImages.googleIcon,
                        onTap: () {
                          GoogleAuth().loginWithGoogle(context);
                        },
                      ),
                      SizedBox(width: 15),
                      CustomAuthWith(
                        icon: AppImages.facebookIcon,
                        onTap: () {},
                      ),
                      SizedBox(width: 15),
                      CustomAuthWith(icon: AppImages.appleIcon, onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
