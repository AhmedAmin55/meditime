import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';


class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.dayName,
    required this.dayNumber,
    required this.isToday,
  });

  final String dayName;
  final String dayNumber;
  final isToday;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: isToday ? AppColors.splashScreenColor : AppColors.white,
          borderRadius: BorderRadius.circular(13),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: AppTextsStyle.spaceGroteskRegular13(context).copyWith(
                fontSize: 14,
                color: isToday ? AppColors.white : AppColors.notTodayColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNumber,
              style: AppTextsStyle.spaceGroteskMedium22(context).copyWith(
                fontSize: 15,
                color: isToday ? AppColors.white : AppColors.notTodayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
