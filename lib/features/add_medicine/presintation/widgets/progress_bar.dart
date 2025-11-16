import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';

import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';

class ProgressBar extends StatelessWidget {
  final int isPage;

  const ProgressBar({super.key, required this.isPage });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return SizedBox(
      width: width,
      height: height * 0.007,
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
          return  Container(
              margin: EdgeInsets.only(right: 5),
              width: width * 0.21,
              height: height * 0.007,
              decoration: BoxDecoration(
                color: index <= (context.read<AddMedicineCubit>().isPage)
                    ? AppColors.splashScreenColor
                    : AppColors.progressIndicatorBackgroundColor,
                borderRadius: BorderRadius.circular(2.5),
              ),
            );
          }
      ),
    );
  }
}
