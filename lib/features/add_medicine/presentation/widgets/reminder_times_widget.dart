import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'custom_input_field.dart';

class ReminderTimesWidget extends StatelessWidget {
  const ReminderTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddMedicineCubit>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reminder Times",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...List.generate(cubit.uiRows.length, (index) {
          final reminder = cubit.uiRows[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                // Time Input
                Container(
                  width: width * 0.55,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE8E8E8),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInputField(
                        formWidth: 40,
                        formHeight: 40,
                        horPadding: 5,
                        verPadding: 0,            enableBorder: true,

                        hint: reminder.hour.isEmpty ? "08" : reminder.hour,
                        onChange: (v) => cubit.updateHour(index, v ?? ""),
                      ),
                      const Text(" : ", style: TextStyle(fontSize: 20)),
                      CustomInputField(
                        formWidth: 40,
                        formHeight: 40,
                        horPadding: 5,
                        verPadding: 0,            enableBorder: true,

                        hint: reminder.minute.isEmpty ? "00" : reminder.minute,
                        onChange: (v) => cubit.updateMinute(index, v ?? ""),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => cubit.togglePeriod(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.splashScreenColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            reminder.period,
                            style: const TextStyle(
                              color: AppColors.splashScreenColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Delete
                InkWell(
                  onTap: () => cubit.removeUiRow(index),
                  child: Container(
                    width: width * 0.15,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE8E8E8),
                        width: 0.8,
                      ),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        // Add Button
        GestureDetector(
          onTap: cubit.addEmptyReminder,
          child: Container(
            width: width * 0.55,
            height: height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8E8E8), width: 0.8),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: AppColors.splashScreenColor,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
