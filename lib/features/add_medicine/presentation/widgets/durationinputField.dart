import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'custom_input_field.dart';

class DurationInputField extends StatelessWidget {
  const DurationInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMedicineCubit>();

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 10, top: 3),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("i will take it for"),
          const Spacer(),
          // الرقم
          SizedBox(
            width: 80,
            child: CustomInputField(
              hint: "00",
              onChange: (value) {
                final num = int.tryParse(value ?? "0") ?? 0;
                cubit.setDurationRaw(num);
              },
            ),
          ),
          const SizedBox(width: 10),
          // الوحدة
          SizedBox(
            width: 125,
            child: CustomInputField(
              hint: cubit.selectedUnit,
              isDropdown: true,
              items: const ["days", "weeks", "months", "years"],
              onChange: (unit) {
                cubit.setDurationUnit(unit ?? "days");
              },
            ),
          ),
        ],
      ),
    );
  }
}