import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<bool> {
  DaysCubit()  : super(false);
  void changeCalendarState() {
    emit(!state);
  }
  late DateTime currentDate = DateTime.now();
  late DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday + 1));
  DateTime getStartOfWeek() => startOfWeek;
  DateTime getCurrentDate() => currentDate;

}
