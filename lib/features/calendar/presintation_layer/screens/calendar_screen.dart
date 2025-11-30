
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/business_logic/medicine_cubit/medicinde_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/medicine_model.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_medicine_card.dart';
import '../widgets/calendar_section.dart';
import '../widgets/progress.dart';
// lib/features/calendar/presentation/screens/calendar_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/business_logic/medicine_cubit/medicinde_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/medicine_model.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_medicine_card.dart';
import '../widgets/calendar_section.dart';
import '../widgets/progress.dart';

// lib/features/calendar/presentation/screens/calendar_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/business_logic/medicine_cubit/medicinde_cubit.dart';
import '../../../../core/constants/app_colors.dart';
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
              onTap: () => context.read<DaysCubit>().changeCalendarState(),
              child: const Center(child: Icon(Icons.keyboard_arrow_down)),
            ),
            const SizedBox(height: 20),

            // ==================== جرعات اليوم المختار ====================
            Expanded(
              child: BlocBuilder<DaysCubit, DateTime>(
                builder: (context, selectedDate) {
                  // اليوم المختار بدون وقت
                  final selectedDay = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                  );

                  // جلب كل الأدوية
                  final List<MedicineModel> allMedicines = context.read<MedicineCubit>().state is MedicineLoaded
                      ? (context.read<MedicineCubit>().state as MedicineLoaded).medicines
                      : <MedicineModel>[];

                  // الفلترة السحرية: أي دواء عنده جرعة في هذا اليوم بالضبط
                  final List<MedicineModel> todayMedicines = allMedicines.where((med) {
                    return med.reminderTimesStatus.any((status) {
                      final reminderDate = status.reminderTime.toDate();
                      final reminderDay = DateTime(reminderDate.year, reminderDate.month, reminderDate.day);
                      return reminderDay == selectedDay;
                    });
                  }).toList();

                  // لو مفيش جرعات اليوم
                  if (todayMedicines.isEmpty) {
                    return const Center(
                      child: Text(
                        "لا توجد جرعات في هذا اليوم",
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    );
                  }

                  // ترتيب الجرعات حسب الوقت في اليوم المختار
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CalendarMedicineCard(
                          medicine: todayMedicines[index],
                        ),
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