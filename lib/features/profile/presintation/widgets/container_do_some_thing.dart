import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

import '../../../../core/constants/app_colors.dart';

class ContainerDoSomeThing extends StatelessWidget {
  const ContainerDoSomeThing({super.key, required this.title, required this.onTap});
final String title;
final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: height*0.06,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: Center(
          child: Text(title,style: AppTextsStyle.spaceGroteskMedium22(context).copyWith(
            fontSize: 15
          ),),
        ),
      ),
    );
  }
}
