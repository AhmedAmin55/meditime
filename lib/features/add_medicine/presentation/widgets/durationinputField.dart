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
          CustomInputField(
            formWidth: 50,
            formHeight: 40,
            horPadding: 10,
            verPadding: 0,
            hint: "00",
            enableBorder: true,
            onChange: (value) {
              final num = int.tryParse(value ?? "0") ?? 0;
              cubit.setDurationRaw(num);
            },
          ),
          const SizedBox(width: 10),
          // الوحدة
          CustomInputField(
            hint: cubit.selectedUnit,
            formWidth: 100,
            formHeight: 40,
            dropdownHeight: 120,
            dropdownWidth: 100,
            verPadding: 0,
            horPadding: 0,
            isDropdown: true,
            items: const ["days", "weeks", "months", "years"],
            onChange: (unit) {
              cubit.setDurationUnit(unit ?? "days");
            },
          ),
        ],
      ),
    );
  }
}