// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'custom_input_field.dart';

class CustomizeDaysWidget extends StatelessWidget {
  const CustomizeDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddMedicineCubit>();

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
          const Text("Notify me"),
          const Spacer(),
          SizedBox(
            width: 190,
            child: CustomInputField(
              hint: cubit.notifyMe,
              isDropdown: true,
              formWidth: 170,
              formHeight: 40,
              dropdownHeight: 120,
              dropdownWidth: 170,
              verPadding: 0,
              horPadding: 0,
              items: const [
                'Everyday',
                'Every saturday',
                'Every sunday',
                'Every monday',
                'Every tuesday',
                'Every wednesday',
                'Every thursday',
                'Every friday',
              ],
              onChange: (value) {
                cubit.setNotifyMe(value ?? "Everyday");
              },
            ),
          ),
        ],
      ),
    );
  }
}
