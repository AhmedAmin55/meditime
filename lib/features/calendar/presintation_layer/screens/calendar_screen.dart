
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            CalendarHeader(),
            ProgressSection(),
            SizedBox(height: 20),
            CalendarSection(),
            GestureDetector(
              onTap: () {
                context.read<DaysCubit>().changeCalendarState();
              },
              child: Center(child: Icon(Icons.keyboard_arrow_down)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.scaffoldColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 16, left: 16),
                  child: ListView.builder(
                    itemCount: medicineList.length,
                    itemBuilder: (ctx, index) =>
                        CalendarMedicineCard(index: index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
