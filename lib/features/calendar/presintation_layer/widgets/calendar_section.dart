import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic_layer/days_cubit/days_cubit.dart';
import 'day_widget.dart';

class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<DaysCubit, bool>(
      builder: (context, state) {
        List<DateTime> days = List.generate(
          state ? 28 : 7,
          (index) => context.read<DaysCubit>().getStartOfWeek().add(
            Duration(days: index),
          ),
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: state ? height * 0.31 : height * 0.07,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 2 / 2.2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 3,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = DateFormat('E').format(days[index]);
                final date = DateFormat('d').format(days[index]);
                final isToday =
                    days[index].day ==
                    context.read<DaysCubit>().getCurrentDate().day;
                return DayWidget(
                  dayName: day,
                  dayNumber: date,
                  isToday: isToday,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
