import 'package:meditime/core/constants/app_texts.dart';

extension AppValidators on String? {
  String? validateRequired(String message) {
    if (this!.isEmpty || this == null) {
      return message;
    }
    return null;
  }

  String? validateEmail() {
    if (this!.isEmpty || this == null) {
      return AppTexts.emailEmpty;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this!)) {
      return AppTexts.emailInvalid;
    }
    return null;
  }

  String? validatePassword() {
    if (this == null || this!.isEmpty) {
      return AppTexts.passwordEmpty;
    }
    if (this!.length < 8) {
      return AppTexts.passwordTooShort;
    }
    return null;
  }

  String? validateConfirmPassword(String password) {
    if (this == null || this!.isEmpty) {
      return AppTexts.confirmPasswordEmpty;
    }
    if (this != password) {
      return AppTexts.passwordsDoNotMatch;
    }
    return null;
  }

  String? validateFirstName() {
    if (this == null || this!.isEmpty) {
      return AppTexts.NameEmpty;
    }
    if (this!.length < 5) {
      return AppTexts.nameTooShort;
    }
    return null;
  }

  String? validatePhone() {
    if (this == null || this!.isEmpty) {
      return AppTexts.mobileNumberEmpty;
    }
    if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(this!)) {
      return AppTexts.mobileNumberInvalid;
    }
    return null;
  }


}
