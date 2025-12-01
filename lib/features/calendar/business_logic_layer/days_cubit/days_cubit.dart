// days_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'days_state.dart';
class DaysCubit extends Cubit<DaysState> {
  DaysCubit() : super(DaysInitial());

  void selectDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    emit(DaySelected(normalized, state.isCalendarOpened));
  }

  void toggleCalendar() {
    emit(CalendarToggled(state.selectedDate, !state.isCalendarOpened));
  }

  // getters عشان نستخدمهم في الـ UI بسهولة
  DateTime get selectedDate => state.selectedDate;
  bool get isCalendarOpened => state.isCalendarOpened;
}