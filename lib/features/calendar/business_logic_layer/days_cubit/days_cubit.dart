import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'days_state.dart';



class DaysCubit extends Cubit<DateTime> {
  DaysCubit() : super(DateTime.now());

  void selectDay(DateTime day) {
    emit(DateTime(day.year, day.month, day.day));
  }

  void changeCalendarState() {
    // لو عايز تضيف فانكشن تانية بعدين
  }
}