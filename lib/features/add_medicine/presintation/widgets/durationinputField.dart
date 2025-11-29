import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/add_medicine/presintation/widgets/custom_input_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';


class DurationInputField extends StatelessWidget {
  final TextEditingController? numberController;
  final String? selectedUnit;
  final Function(String?)? onUnitChanged;

  DurationInputField({
    super.key,
    this.numberController,
    this.selectedUnit,
    this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: 15, right: 10, top: 3),
      height: height * 0.055,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("i will take it for"),
          Spacer(),

          // 🔵 رقم المدة
          CustomInputField(
            onChange: (value) {
              int num = int.tryParse(value ?? "") ?? 0;
              context.read<AddMedicineCubit>().setDurationRaw(num);
            },
            formWidth: 50,
            controller: numberController,
            formHeight: 40,
            horPadding: 10,
            verPadding: 0,
            hint: "00",
          ),

          SizedBox(width: 10),

          // 🟣 اختيار الوحدة
          CustomInputField(
            onChange: (unit) {
              context.read<AddMedicineCubit>().setDurationUnit(unit!);
            },
            isDropdown: true,
            formWidth: 100,
            formHeight: 40,
            dropdownHeight: 120,
            dropdownWidth: 100,
            verPadding: 0,
            hint: "days",
            items: ["days", "weeks", "months", "years"],
            horPadding: 0,
          ),
        ],
      ),
    );
  }
}
