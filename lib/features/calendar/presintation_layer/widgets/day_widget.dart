import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

// day_widget.dart ← استبدل الكود كله باللي تحت

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

// day_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

class DayWidget extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isSelected;

  const DayWidget({
    super.key,
    required this.date,
    required this.isToday,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DaysCubit>().selectDay(date);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: isSelected || isToday
              ? AppColors.splashScreenColor
              : AppColors.white,
          borderRadius: BorderRadius.circular(13),
          border: isSelected
              ? Border.all(color: AppColors.splashScreenColor, width: 2.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(date).substring(0, 3),
              style: AppTextsStyle.spaceGroteskRegular13(context).copyWith(
                fontSize: 14,
                color: isSelected || isToday ? Colors.white : AppColors.notTodayColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: AppTextsStyle.spaceGroteskMedium22(context).copyWith(
                fontSize: 15,
                color: isSelected || isToday ? Colors.white : AppColors.notTodayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}