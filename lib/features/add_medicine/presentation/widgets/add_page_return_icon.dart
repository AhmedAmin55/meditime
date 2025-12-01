// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:meditime/core/business_logic/nav_cubit/nav_cubit.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';

class AddPageReturnIcon extends StatelessWidget {
  const AddPageReturnIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Align(
      alignment: const Alignment(-0.85, 1),
      heightFactor: 1.4,
      child: GestureDetector(
        onTap: () {
          final cubit = context.read<AddMedicineCubit>();
          if (cubit.isPage > 0) {
            cubit.goBack();
          } else {
            context.read<NavCubit>().changeScreen(index: 0);
          }
        },
        child: Container(
          width: width * 0.17,
          height: height * 0.05,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.waitingMedicineColor.withOpacity(0.53),
              width: 0.3,
            ),
          ),
          child: Center(
            child: Image.asset(
              AppImages.returnIcon,
              width: width * 0.05,
              height: height * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
