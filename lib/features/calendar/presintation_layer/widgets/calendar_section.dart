// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../business_logic_layer/days_cubit/days_cubit.dart';
import 'day_widget.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  List<DateTime> _generate28DaysStartingSaturday(DateTime anyDateInPeriod) {
    final daysSinceSaturday = anyDateInPeriod.weekday - DateTime.saturday;
    final startSaturday = anyDateInPeriod.subtract(
      Duration(
        days: daysSinceSaturday < 0 ? daysSinceSaturday + 7 : daysSinceSaturday,
      ),
    );
    return List.generate(
      28,
      (index) => startSaturday.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<DaysCubit, DaysState>(
      builder: (context, state) {
        final selectedDate = state.selectedDate;

        return SizedBox(
          height: state.isCalendarOpened ? height * 0.31 : height * 0.075,
          child: PageView.builder(
            controller: PageController(initialPage: 1000),
            onPageChanged: (pageIndex) {
              final baseDate = DateTime.now().add(
                Duration(days: (pageIndex - 1000) * 28),
              );
              final days = _generate28DaysStartingSaturday(baseDate);
              final currentOffset = selectedDate
                  .difference(
                    _generate28DaysStartingSaturday(selectedDate).first,
                  )
                  .inDays;
              final newSelectedDate = days[currentOffset.clamp(0, 27)];
              context.read<DaysCubit>().selectDay(newSelectedDate);
            },
            itemBuilder: (context, pageIndex) {
              final baseDate = DateTime.now().add(
                Duration(days: (pageIndex - 1000) * 28),
              );
              final days = _generate28DaysStartingSaturday(baseDate);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 2 / 2.2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 3,
                  ),
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final isToday =
                        day.year == DateTime.now().year &&
                        day.month == DateTime.now().month &&
                        day.day == DateTime.now().day;
                    final isSelected =
                        day.year == selectedDate.year &&
                        day.month == selectedDate.month &&
                        day.day == selectedDate.day;

                    return DayWidget(
                      date: day,
                      isToday: isToday,
                      isSelected: isSelected,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
