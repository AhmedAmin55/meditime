import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:meditime/features/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/navbar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/services/auth_user.dart';
import '../../data/services/login_with_google_services.dart';
import 'custom_login_with.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import 'login_or_signup_with.dart';

class SignupScreenBody extends StatelessWidget {
  SignupScreenBody({super.key});

  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _mobileController =
      TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => Navbar()),
          );
        } else if (state is RegisterFailure) {
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
                        top: height * 0.02,
                        left: 30,
                        right: 30,
                      ),
                      children: [
                        Text(
                          AppTexts.getStarted,
                          style: AppTextsStyle.merriweatherBold30(
                            context,
                          ).copyWith(color: AppColors.splashScreenColor),
                        ),
                        Text(
                          AppTexts.signUpToManageYourMedications,
                          style: AppTextsStyle.merriweatherRegular20(context)
                              .copyWith(
                                color: AppColors.splashScreenColor.withOpacity(
                                  0.7,
                                ),
                              ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          AppTexts.fullName,
                          style: AppTextsStyle.merriweatherRegular20(
                            context,
                          ).copyWith(color: AppColors.black.withOpacity(0.5)),
                        ),
                        SizedBox(height: 3),
                        CustomTextformfield(
                          keyboardType: TextInputType.name,
                          prefixIcon: AppImages.nameIcon,
                          hintText: AppTexts.enterYourFullName,
                          controller: _nameController,
                          validator: (value) => value!.trim().validateFirstName(),
                          hintTextStyle: AppTextsStyle.montserratRegular18(
                            context,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppTexts.emailAddress,
                          style: AppTextsStyle.merriweatherRegular20(
                            context,
                          ).copyWith(color: AppColors.black.withOpacity(0.5)),
                        ),
                        SizedBox(height: 3),
                        CustomTextformfield(
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: AppImages.emailIocn,
                          hintText: AppTexts.enterYourEmail,
                          controller: _emailController,
                          validator: (value) => value!.trim().validateEmail(),
                          hintTextStyle: AppTextsStyle.montserratRegular18(
                            context,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppTexts.password,
                          style: AppTextsStyle.merriweatherRegular20(
                            context,
                          ).copyWith(color: AppColors.black.withOpacity(0.5)),
                        ),
                        SizedBox(height: 3),
                        CustomTextformfield(
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: AppImages.passIcon,
                          obscureText: true,
                          hintText: AppTexts.enterYourPassword,
                          visibleSuffixIcon: AppImages.visibleIcon,
                          inVisibleSuffixIcon: AppImages.inVisibleIcon,
                          controller: _passwordController,
                          validator: (value) => value!.trim().validatePassword(),
                          hintTextStyle: AppTextsStyle.montserratRegular18(
                            context,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppTexts.mobileNumber,
                          style: AppTextsStyle.merriweatherRegular20(
                            context,
                          ).copyWith(color: AppColors.black.withOpacity(0.5)),
                        ),
                        SizedBox(height: 3),
                        CustomTextformfield(
                          keyboardType: TextInputType.phone,
                          prefixIcon: AppImages.mobileIcon,
                          hintText: AppTexts.enterYourMobileNumber,
                          controller: _mobileController,
                          validator: (value) => value!.trim().validatePhone(),
                          hintTextStyle: AppTextsStyle.montserratRegular18(
                            context,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: PrimaryButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).registerUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name:_nameController.text ,
                                  phoneNumber: _mobileController.text,
                                );
                              }
                            },
                            color: AppColors.splashScreenColor,
                            width: width * 0.77,
                            title: AppTexts.signup,
                            height: height * 0.048,
                          ),
                        ),
                        SizedBox(height: 15),
                        LoginOrSignupWith(loginOrSignup: AppTexts.orLoginWith),
                        SizedBox(height: 25),
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
                            CustomAuthWith(
                              icon: AppImages.appleIcon,
                              onTap: () {},
                            ),
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
