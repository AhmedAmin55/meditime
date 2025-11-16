import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, this.onTap});
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width*0.5,
          child: CircleAvatar(
            radius: width * 0.16,
            backgroundColor: AppColors.splashScreenColor,
            child: Image.asset(AppImages.personIcon, width: 80),
          ),
        ),
        Positioned(
          bottom: 0,
          right:30,
          child: GestureDetector(
            onTap: onTap??(){},
            child: Container(
              height: height * 0.055,
              width: width * 0.1,
              decoration: BoxDecoration(
                color: AppColors.changeUserImageColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(AppImages.addScreenIcon,color: AppColors.splashScreenColor,width: 12,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
