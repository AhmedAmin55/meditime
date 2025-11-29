import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/reminder_model.dart';

part 'add_medicine_state.dart';



class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit() : super(AddMedicineInitial());

  int isPage = 0;

  TextEditingController assignTo = TextEditingController();
  TextEditingController medicineName = TextEditingController();
  TextEditingController specialInstructions = TextEditingController();
  TextEditingController dosage = TextEditingController();

  String selectedType = "Pills";
  String selectedUnit = "days";
  int duration = 0;
  int durationRaw = 0;
  String notifyMe = "Everyday";
  final namePageKey = GlobalKey<FormState>();

  List<ReminderModel> uiRows = [];

  List<ReminderModel> reminderTimes = [];

  String period = "AM";

  void setDurationRaw(int number) {
    durationRaw = number;
    _calculateDuration();
  }

  void setDurationUnit(String unit) {
    selectedUnit = unit;
    _calculateDuration();
  }
  void saveSingleReminder(int index) {
    final r = uiRows[index];

    reminderTimes.add(ReminderModel(
      hour: r.hour,
      minute: r.minute,
      period: r.period,
    ));

    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }
  void _calculateDuration() {
    switch (selectedUnit) {
      case "days":
        duration = durationRaw * 1;
        break;
      case "weeks":
        duration = durationRaw * 7;
        break;
      case "months":
        duration = durationRaw * 30;
        break;
      case "years":
        duration = durationRaw * 365;
        break;
    }
    emit(AddMedicineDosage());
  }

  void addEmptyReminder() {
    uiRows.add(ReminderModel(hour: "", minute: "", period: "AM"));
    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }

  void updateHour(int index, String h) {
    uiRows[index] = ReminderModel(
      hour: h,
      minute: uiRows[index].minute,
      period: uiRows[index].period,
    );
    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }

  void updateMinute(int index, String m) {
    uiRows[index] = ReminderModel(
      hour: uiRows[index].hour,
      minute: m,
      period: uiRows[index].period,
    );
    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }

  void togglePeriod(int index) {
    final p = uiRows[index].period == "AM" ? "PM" : "AM";
    uiRows[index] = ReminderModel(
      hour: uiRows[index].hour,
      minute: uiRows[index].minute,
      period: p,
    );
    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }

  void removeUiRow(int index) {
    uiRows.removeAt(index);
    emit(AddMedicineFrequency(reminderTimes: uiRows));
  }

  void saveReminderTimes() {
    reminderTimes = List.from(uiRows);
    emit(AddMedicineReview());
  }

  void addMedicineChanger({required int newIndex}) {
    if (newIndex >= 0) {
      isPage = newIndex;
    }
    switch (isPage) {
      case 1:
        emit(AddMedicineDosage());
        break;
      case 2:
        emit(AddMedicineFrequency(reminderTimes: uiRows));
        break;
      case 3:
        saveReminderTimes();
        break;
      default:
        emit(AddMedicineInitial());
    }
  }
}
