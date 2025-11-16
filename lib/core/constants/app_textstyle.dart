import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';


class AppTextsStyle {
//spaceGrotesk
  static TextStyle spaceGroteskMedium22(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: AppFonts.spaceGroteskFont,
      fontSize: getResponsiveTextsize(context, baseFontsize: 22),
      fontWeight: FontWeight.w500,
    );
  }
  static TextStyle spaceGroteskRegular13(BuildContext context) {
    return TextStyle(
      color: AppColors.numberOfCapsuleColor,
      fontFamily: AppFonts.spaceGroteskFont,
      fontSize: getResponsiveTextsize(context, baseFontsize: 13),
      fontWeight: FontWeight.w400,
    );
  }
//merriweather
  static TextStyle merriweatherBold30(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontFamily: AppFonts.merriweatherFont,
      fontSize: getResponsiveTextsize(context, baseFontsize: 30),
      fontWeight: FontWeight.w900,
    );
  }
  static TextStyle merriweatherRegular20(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontFamily: AppFonts.merriweatherFont,
      fontSize: getResponsiveTextsize(context, baseFontsize: 20),
    );
  }
//Poppins
  static TextStyle poppinsRegular25(BuildContext context) {
    return TextStyle(
      color: AppColors.timeColor,
      fontFamily: AppFonts.poppins,
      fontSize: getResponsiveTextsize(context, baseFontsize: 25),
    );
  }
  static TextStyle poppinsBold15(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: AppFonts.poppins,
      fontWeight: FontWeight.w700,
      fontSize: getResponsiveTextsize(context, baseFontsize: 15),
    );
  }
  static TextStyle poppinsMedium20(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: AppFonts.poppins,
      fontWeight: FontWeight.w500,
      fontSize: getResponsiveTextsize(context, baseFontsize: 20),
    );
  }
//LeagueSpartan
  static TextStyle leagueSpartanRegular14(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: AppFonts.leagueSpartan,
      fontSize: getResponsiveTextsize(context, baseFontsize: 18),
    );
  }
  //Montserrat
  static TextStyle montserratRegular18(BuildContext context) {
    return TextStyle(
      color: AppColors.timeColor.withOpacity(0.8),
      fontFamily: AppFonts.montserrat,
      fontSize: getResponsiveTextsize(context, baseFontsize: 18),
    );
  }

  static TextStyle montserratSemiBold22(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontFamily: AppFonts.montserrat,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveTextsize(context, baseFontsize: 22),
    );
  }
}

  double getResponsiveTextsize(BuildContext context, {
    required double baseFontsize,
  }) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontsize = scaleFactor * baseFontsize;
    double lowerLimit = baseFontsize * 0.8;
    double upperLimit = baseFontsize * 1.2;

    return responsiveFontsize.clamp(lowerLimit, upperLimit);
  }

  double getScaleFactor(BuildContext context) {
    double width = MediaQuery
        .sizeOf(context)
        .width;
    if (width <= 600) {
      return width / 560;
    }
    if (width > 600 && width <= 1100) {
      return width / 1050;
    } else {
      return width / 1900;
    }
  }

