import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.title,
    required this.value,
    required this.Icon,
  });

  final String title;
  final String value;
  final String Icon;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1.3,
      child: Container(
        padding: EdgeInsets.only(left: 10,top: 5),
        decoration: BoxDecoration(
          color: AppColors.splashScreenColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(Icon, width: 24),
                SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextsStyle.poppinsMedium20(
                    context,
                  ).copyWith(color: AppColors.white,fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                value,
                style : AppTextsStyle.poppinsMedium20(context).copyWith(color: AppColors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
