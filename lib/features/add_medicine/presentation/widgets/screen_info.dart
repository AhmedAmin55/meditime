import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

import '../../../../core/constants/app_colors.dart';


class ScreenInfo extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const ScreenInfo({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          // Container(
          //   width: 77,
          //   height: 77,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(13),
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.black.withOpacity(0.25),
          //         blurRadius: 2,
          //         offset: const Offset(1, 1),
          //       ),
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 8.0, left: 8),
          //     child:
          //   ),
          // ),
          Image.asset(imagePath,width: width*0.25,),
          const SizedBox(height: 12),
           Text(
            title,
             style: AppTextsStyle.montserratSemiBold22(context),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTextsStyle.montserratSemiBold22(context).copyWith(
              color: AppColors.timeColor,
              fontSize: 13
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
