import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

class LoginOrSignupWith extends StatelessWidget {
  const LoginOrSignupWith({super.key, required this.loginOrSignup});
final String loginOrSignup;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width*0.25,
          height: height*0.001,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.white,
                AppColors.white,
                AppColors.waitingMedicineColor.withOpacity(0.2),
                AppColors.waitingMedicineColor.withOpacity(0.4),
              ],
            ),
          ),
        ),
        SizedBox(width:width*0.04),
        Text(loginOrSignup,style: AppTextsStyle.merriweatherRegular20(
          context,
        ).copyWith(color: AppColors.black.withOpacity(0.3),fontSize: 13),),
        SizedBox(width:width*0.04),
        Container(
          width: width*0.25,
          height: height*0.001,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                AppColors.white,
                AppColors.white,
                AppColors.waitingMedicineColor.withOpacity(0.2),
                AppColors.waitingMedicineColor.withOpacity(0.4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
