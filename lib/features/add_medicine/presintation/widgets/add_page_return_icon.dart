import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/business_logic/nav_cubit/nav_cubit.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';

import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';

class AddPageReturnIcon extends StatefulWidget {
  const AddPageReturnIcon({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  State<AddPageReturnIcon> createState() => _AddPageReturnIconState();
}

class _AddPageReturnIconState extends State<AddPageReturnIcon> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment(-0.85, 1),
      heightFactor: 1.4,
      child: GestureDetector(
        onTap: () {
         if ((context).read<AddMedicineCubit>().isPage >0){
           (context).read<AddMedicineCubit>().addMedicineChanger(
             newIndex: (context).read<AddMedicineCubit>().isPage - 1,
           );
         }else{
           (context).read<NavCubit>().changeScreen(index: 0);
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
