import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
class SignupButton extends StatelessWidget {
  const SignupButton({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    final double width =MediaQuery.of(context).size.width;
    final double height =MediaQuery.of(context).size.height;
    return Container(
      height: height*0.070,
      decoration: BoxDecoration(
        color: AppColors.splashScreenColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
          title,
            style: AppTextsStyle.merriweatherRegular20(
              context,
            ),
          ),
          SizedBox(height: height*0.01 ,),
          Container(
            height: height*0.009,
            decoration: BoxDecoration(
                gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.waitingMedicineColor,
                      AppColors.white,
                    ]
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white,
                    spreadRadius: 20,
                    offset: Offset(0, 20),
                  )
                ]
            ),

          ),
        ],
      ),
    );
  }
}
