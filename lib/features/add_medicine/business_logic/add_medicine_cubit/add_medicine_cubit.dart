// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import '../../data/models/reminder_model.dart';

part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit() : super(AddMedicineInitial()) {
    assignTo.text = "Me";
    selectedType = "Pills";
    selectedUnit = "days";
    notifyMe = "Everyday";

    addEmptyReminder();

    _updateState();
  }

  int isPage = 0;

  final TextEditingController assignTo = TextEditingController();
  final TextEditingController medicineName = TextEditingController();
  final TextEditingController specialInstructions = TextEditingController();
  final TextEditingController dosage = TextEditingController();

  String selectedType = "Pills";
  String selectedUnit = "days";
  int duration = 0;
  int durationRaw = 0;
  String notifyMe = "Everyday";

  final namePageKey = GlobalKey<FormState>();
  List<ReminderModel> uiRows = [];

  void _updateState() {
    emit(AddMedicineInProgress(currentPage: isPage, uiRows: List.from(uiRows)));
  }

  void setDurationRaw(int number) {
    durationRaw = number;
    _calculateDuration();
    _updateState();
  }

  void setDurationUnit(String unit) {
    selectedUnit = unit;
    _calculateDuration();
    _updateState();
  }

  void setNotifyMe(String value) {
    notifyMe = value;
    _updateState();
  }

  void _calculateDuration() {
    switch (selectedUnit) {
      case "days":
        duration = durationRaw;
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
  }

  void addEmptyReminder() {
    uiRows.add(ReminderModel(hour: "", minute: "", period: "AM"));
    _updateState();
  }

  void updateHour(int index, String h) {
    uiRows[index] = ReminderModel(
      hour: h,
      minute: uiRows[index].minute,
      period: uiRows[index].period,
    );
    _updateState();
  }

  void updateMinute(int index, String m) {
    uiRows[index] = ReminderModel(
      hour: uiRows[index].hour,
      minute: m,
      period: uiRows[index].period,
    );
    _updateState();
  }

  void togglePeriod(int index) {
    final p = uiRows[index].period == "AM" ? "PM" : "AM";
    uiRows[index] = ReminderModel(
      hour: uiRows[index].hour,
      minute: uiRows[index].minute,
      period: p,
    );
    _updateState();
  }

  void removeUiRow(int index) {
    uiRows.removeAt(index);
    _updateState();
  }

  bool get canGoNext {
    switch (isPage) {
      case 0:
        return medicineName.text.trim().isNotEmpty;
      case 1:
        return dosage.text.trim().isNotEmpty;
      case 2:
        if (duration <= 0) return false;
        if (uiRows.isEmpty) return false;

        for (var row in uiRows) {
          final hourStr = row.hour.trim();
          final minuteStr = row.minute.trim();

          if (hourStr.isEmpty || minuteStr.isEmpty) return false;

          final hour = int.tryParse(hourStr);
          final minute = int.tryParse(minuteStr);

          if (hour == null || minute == null) return false;

          if (hour < 1 || hour > 12) return false;

          if (minute < 0 || minute > 59) return false;
        }
        return true;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void goNext() {
    if (canGoNext && isPage < 3) {
      isPage++;
      _updateState();
    }
  }

  void goBack() {
    if (isPage > 0) {
      isPage--;
      _updateState();
    }
  }

  void changeDosage() {
    emit(AddMedicineInProgress(currentPage: isPage, uiRows: List.from(uiRows)));
  }

  void reset() {
    isPage = 0;
    assignTo.text = "Me";
    medicineName.clear();
    specialInstructions.clear();
    dosage.clear();
    selectedType = "Pills";
    duration = 0;
    durationRaw = 0;
    selectedUnit = "days";
    notifyMe = "Everyday";
    uiRows.clear();
    emit(AddMedicineInitial());
  }
}
