import 'package:flutter/material.dart';
import 'day_widget.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';



class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  // نولّد 28 يوم تبدأ من السبت
  List<DateTime> _generate28DaysStartingSaturday(DateTime anyDateInPeriod) {
    // نجيب أقرب سبت قبل أو في التاريخ ده
    final daysSinceSaturday = anyDateInPeriod.weekday - DateTime.saturday;
    final startSaturday = anyDateInPeriod.subtract(Duration(
      days: daysSinceSaturday < 0 ? daysSinceSaturday + 7 : daysSinceSaturday,
    ));

    return List.generate(28, (index) => startSaturday.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<DaysCubit, DateTime>(
      builder: (context, selectedDate) {
        return SizedBox(
          height: height * 0.31,
          child: PageView.builder(
            controller: PageController(initialPage: 1000),
            onPageChanged: (pageIndex) {
              // نحسب أول سبت في الفترة الجديدة
              final baseDate = DateTime.now().add(Duration(days: (pageIndex - 1000) * 28));
              final daysSinceSaturday = baseDate.weekday - DateTime.saturday;
              final newStartSaturday = baseDate.subtract(Duration(
                days: daysSinceSaturday < 0 ? daysSinceSaturday + 7 : daysSinceSaturday,
              ));

              // نحافظ على نفس المسافة من السبت
              final currentDaysFromSaturday = selectedDate.difference(
                _generate28DaysStartingSaturday(selectedDate).first,
              ).inDays;

              final newSelectedDate = newStartSaturday.add(Duration(days: currentDaysFromSaturday.clamp(0, 27)));
              context.read<DaysCubit>().selectDay(newSelectedDate);
            },
            itemBuilder: (context, pageIndex) {
              // نحسب أول سبت في هذه الصفحة
              final baseDate = DateTime.now().add(Duration(days: (pageIndex - 1000) * 28));
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
                    final isToday = day.year == DateTime.now().year &&
                        day.month == DateTime.now().month &&
                        day.day == DateTime.now().day;

                    final isSelected = day.year == selectedDate.year &&
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