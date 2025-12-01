// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../../../../core/widgets/primary_button.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key, required this.passwordController});

  final TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text("Edit your name"),
      content: Form(
        key: _formKey,
        child: CustomTextformfield(
          prefixIcon: AppImages.editNameIcon,
          keyboardType: TextInputType.text,
          controller: passwordController,
          validator: (value) =>
              value!.trim().validateRequired(AppTexts.enterYourFullName),
          hintText: "Ahmed Amin",
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PrimaryButton(
              onTap: () {
                Navigator.pop(context);
              },
              title: "Cancel",
              color: AppColors.splashScreenColor,
              width: width * 0.25,
              height: height * 0.05,
            ),
            PrimaryButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {}
              },
              title: "Edit",
              color: AppColors.splashScreenColor,
              width: width * 0.25,
              height: height * 0.05,
            ),
          ],
        ),
      ],
    );
  }
}
