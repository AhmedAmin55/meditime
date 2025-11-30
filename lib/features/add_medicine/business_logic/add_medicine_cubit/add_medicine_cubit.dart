// features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';

part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit() : super(AddMedicineInitial()) {
    // Default Values
    assignTo.text = "Me";
    selectedType = "Pills";
    selectedUnit = "days";
    notifyMe = "Everyday";

    // مهم جدًا: نضيف سطر وقت واحد تلقائيًا أول ما نفتح الـ Add Flow
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
    emit(AddMedicineInProgress(
      currentPage: isPage,
      uiRows: List.from(uiRows),
    ));
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
      case "days":   duration = durationRaw; break;
      case "weeks":  duration = durationRaw * 7; break;
      case "months": duration = durationRaw * 30; break;
      case "years":  duration = durationRaw * 365; break;
    }
  }

  void addEmptyReminder() {
    uiRows.add(ReminderModel(hour: "", minute: "", period: "AM"));
    _updateState();
  }

  void updateHour(int index, String h) {
    uiRows[index] = ReminderModel(hour: h, minute: uiRows[index].minute, period: uiRows[index].period);
    _updateState();
  }

  void updateMinute(int index, String m) {
    uiRows[index] = ReminderModel(hour: uiRows[index].hour, minute: m, period: uiRows[index].period);
    _updateState();
  }

  void togglePeriod(int index) {
    final p = uiRows[index].period == "AM" ? "PM" : "AM";
    uiRows[index] = ReminderModel(hour: uiRows[index].hour, minute: uiRows[index].minute, period: p);
    _updateState();
  }

  void removeUiRow(int index) {
    uiRows.removeAt(index);
    _updateState();
  }

  // === هل نقدر نروح للصفحة الجاية؟ ===
  bool get canGoNext {
    switch (isPage) {
      case 0:
        return medicineName.text.trim().isNotEmpty;
      case 1:
        return dosage.text.trim().isNotEmpty;
      case 2:
        return duration > 0 &&
            uiRows.isNotEmpty &&
            uiRows.any((r) =>
            r.hour.trim().isNotEmpty &&
                r.minute.trim().isNotEmpty &&
                int.tryParse(r.hour) != null &&
                int.tryParse(r.minute) != null);
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