part of 'days_cubit.dart';

@immutable
sealed class DaysState {
  final DateTime selectedDate;
  final bool isCalendarOpened;

  const DaysState({required this.selectedDate, required this.isCalendarOpened});
}

class DaysInitial extends DaysState {
  DaysInitial() : super(selectedDate: DateTime.now(), isCalendarOpened: false);
}

class CalendarToggled extends DaysState {
  const CalendarToggled(DateTime date, bool opened)
    : super(selectedDate: date, isCalendarOpened: opened);
}

class DaySelected extends DaysState {
  const DaySelected(DateTime date, bool opened)
    : super(selectedDate: date, isCalendarOpened: opened);
}
