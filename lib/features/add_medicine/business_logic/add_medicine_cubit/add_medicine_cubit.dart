import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/services/medicine_firebase_service.dart';




part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  // Create the service instance
  final MedicineFirebaseService _medicineService = MedicineFirebaseService();

  AddMedicineCubit() : super(AddMedicineInitial());

  int isPage = 0;
  final nameFormKey = GlobalKey<FormState>();

  // Page 0 - Name & Instructions
  String? medicineName;
  String? assignToWho;
  String? specialInstructions;

  // Page 1 - Dosage & Type
  String? dosage;
  String? medicineType;

  // Page 2 - Frequency & Time
  String? durationNumber;
  String? durationUnit; // days, weeks, months, years
  String? customizeDays; // Everyday, Every sunday, etc.
  List<Map<String, dynamic>>? reminderTimes;

  // ============ Methods ============

  void saveNameData({
    required String name,
    required String assignTo,
    String? instructions,
  }) {
    medicineName = name;
    assignToWho = assignTo;
    specialInstructions = instructions;
  }

  void saveDosageData({
    required String dosageAmount,
    required String type,
  }) {
    dosage = dosageAmount;
    medicineType = type;
  }

  void saveFrequencyData({
    required String number,
    required String unit,
    required String days,
    required List<Map<String, dynamic>> times,
  }) {
    durationNumber = number;
    durationUnit = unit;
    customizeDays = days;
    reminderTimes = times;
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
        emit(AddMedicineFrequency());
        break;
      case 3:
        emit(AddMedicineReview());
        break;
      default:
        emit(AddMedicineInitial());
    }
  }

  void clearAllData() {
    medicineName = null;
    assignToWho = null;
    specialInstructions = null;
    dosage = null;
    medicineType = null;
    durationNumber = null;
    durationUnit = null;
    customizeDays = null;
    reminderTimes = null;
    isPage = 0;
    emit(AddMedicineInitial());
  }

  // ============ SAVE TO FIREBASE LOGIC ============
  Future<void> submitMedicine() async {
    emit(AddMedicineLoading());

    try {
      // 1. Basic Validation
      if (medicineName == null || medicineName!.isEmpty) {
        emit(AddMedicineFailure("Medicine name is required"));
        return;
      }
      if (dosage == null || dosage!.isEmpty) {
        emit(AddMedicineFailure("Dosage is required"));
        return;
      }

      // 2. Convert String duration to integer
      int durationInt = 7; // Default fallback
      if (durationNumber != null && durationNumber!.isNotEmpty) {
        durationInt = int.tryParse(durationNumber!) ?? 7;
      }

      // 3. Call the Service
      final success = await _medicineService.saveMedicine(
        medicineName: medicineName!,
        medicineType: medicineType ?? 'Tablet', // Default type
        dosage: dosage!,
        assignTo: assignToWho ?? 'Me', // Default assignment
        specialInstructions: specialInstructions,
        durationInDays: durationInt,
        durationUnit: durationUnit ?? 'days',
        customDay: customizeDays ?? 'Every Day',
        reminderTimes: reminderTimes ?? [],
      );

      if (success) {
        emit(AddMedicineSuccess());
      } else {
        emit(AddMedicineFailure("Failed to save medicine. Please try again."));
      }
    } catch (e) {
      emit(AddMedicineFailure("An error occurred: ${e.toString()}"));
    }
  }
}