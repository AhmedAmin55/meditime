import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/features/add_medicine/presintation/widgets/custom_input_field.dart';

import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';

class ReminderTimesWidget extends StatelessWidget {
  const ReminderTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddMedicineCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Reminder Times"),
        const SizedBox(height: 12),

        // ====== عرض صفوف الـ UI فقط ======
        ...List.generate(cubit.uiRows.length, (index) {
          final reminder = cubit.uiRows[index];

          final hourCtrl = TextEditingController(text: reminder.hour);
          final minuteCtrl = TextEditingController(text: reminder.minute);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color.fromRGBO(232, 232, 232, 0.9),
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomInputField(
                          formWidth: 50,
                          controller: hourCtrl,
                          formHeight: 40,
                          horPadding: 10,
                          verPadding: 0,
                          hint: "08",
                          onChange: (v) {
                            cubit.updateHour(index, v!);
                          },
                        ),

                        const Text(":"),

                        CustomInputField(
                          formWidth: 50,
                          controller: minuteCtrl,
                          formHeight: 40,
                          horPadding: 10,
                          verPadding: 0,
                          hint: "00",
                          onChange: (v) {
                            cubit.updateMinute(index, v!);
                          },
                        ),

                        const SizedBox(width: 12),

                        GestureDetector(
                          onTap: () => cubit.togglePeriod(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.splashScreenColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              reminder.period,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.splashScreenColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                InkWell(
                  onTap: () => cubit.removeUiRow(index),
                  child: Container(
                    width: 48,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(232, 232, 232, 0.9),
                        width: 0.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    cubit.saveSingleReminder(index);
                    print(cubit.reminderTimes[9].hour);
                    print(cubit.reminderTimes[9].minute);
                    print(cubit.reminderTimes[9].period);
                    print(cubit.reminderTimes);
                  },
                  child: Container(
                    width: 48,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(232, 232, 232, 0.9),
                        width: 0.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: AppColors.splashScreenColor, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        // ===== زر إضافة Row =====
        GestureDetector(
          onTap: (){
            cubit.addEmptyReminder();
          },
          child: Container(
            width: 312,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromRGBO(232, 232, 232, 0.9),
                width: 0.5,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: AppColors.splashScreenColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
