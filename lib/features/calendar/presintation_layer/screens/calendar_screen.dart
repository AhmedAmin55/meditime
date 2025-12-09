// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/business_logic/medicine_cubit/medicine_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/models/medicine_model.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_medicine_card.dart';
import '../widgets/calendar_section.dart';
import '../widgets/progress.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CalendarHeader(),
            const ProgressSection(),
            const SizedBox(height: 20),

            const CalendarSection(),
            GestureDetector(
              onTap: () => context.read<DaysCubit>().toggleCalendar(),
              child: const Center(
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<DaysCubit, DaysState>(
                builder: (context, daysState) {
                  final selectedDay = daysState.selectedDate;
                  final List<MedicineModel> allMedicines =
                  context.read<MedicineCubit>().state is MedicineLoaded
                      ? (context.read<MedicineCubit>().state as MedicineLoaded)
                      .medicines
                      : <MedicineModel>[];

                  final List<MedicineModel> todayMedicines = allMedicines.where((med) {
                    return med.reminderTimesStatus.any((status) {
                      final reminderDate = status.reminderTime.toDate();
                      final reminderDay = DateTime(
                        reminderDate.year,
                        reminderDate.month,
                        reminderDate.day,
                      );
                      return reminderDay == selectedDay;
                    });
                  }).toList();
                  if (todayMedicines.isEmpty) {
                    return Center(
                      child: Text(
                        AppTexts.noMedicinesForThisDay,
                        style: AppTextsStyle.poppinsRegular25(context)
                            .copyWith(fontSize: 20),
                      ),
                    );
                  }
                  todayMedicines.sort((a, b) {
                    final timeA = a.reminderTimesStatus
                        .where((s) => s.reminderTime.toDate().day == selectedDay.day)
                        .map((s) => s.reminderTime.toDate())
                        .firstOrNull;
                    final timeB = b.reminderTimesStatus
                        .where((s) => s.reminderTime.toDate().day == selectedDay.day)
                        .map((s) => s.reminderTime.toDate())
                        .firstOrNull;

                    if (timeA == null) return 1;
                    if (timeB == null) return -1;
                    return timeA.compareTo(timeB);
                  });

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: todayMedicines.length,
                    itemBuilder: (context, index) {
                      return CalendarMedicineCard(
                        medicine: todayMedicines,
                        index : index,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}