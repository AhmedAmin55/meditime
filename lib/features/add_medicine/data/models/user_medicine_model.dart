import 'package:cloud_firestore/cloud_firestore.dart';

class UserMedicineModel {
  final String? id;
  final String medicineName;
  final String medicineType;
  final String dosage;
  final String assignTo;
  final String? specialInstructions;
  final int durationInDays;
  final String durationUnit;
  final List<String> customDays;
  final List<String> customTimes;
  final List<Map<String, dynamic>> reminderTimesStatus;
  final String userId;
  final String medicineId;

  UserMedicineModel({
    this.id,
    required this.medicineName,
    required this.medicineType,
    required this.dosage,
    required this.assignTo,
    this.specialInstructions,
    required this.durationInDays,
    required this.durationUnit,
    required this.customDays,
    required this.customTimes,
    required this.reminderTimesStatus,
    required this.userId,
    required this.medicineId,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'custom_days': customDays,
      'custom_times': customTimes,
      'dosage': dosage,
      'duration_in_days': durationInDays,
      'medicine_id': medicineId,
      'reminder_times_status': reminderTimesStatus,
      'special_instructions': specialInstructions ?? '',
      'user_id': userId,
    };
  }

  factory UserMedicineModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserMedicineModel(
      id: doc.id,
      medicineName: data['medicine_name'] ?? '',
      medicineType: data['medicine_type'] ?? '',
      dosage: data['dosage'] ?? '',
      assignTo: data['assign_to'] ?? '',
      specialInstructions: data['special_instructions'],
      durationInDays: data['duration_in_days'] ?? 0,
      durationUnit: data['duration_unit'] ?? 'days',
      customDays: List<String>.from(data['custom_days'] ?? []),
      customTimes: List<String>.from(data['custom_times'] ?? []),
      reminderTimesStatus: List<Map<String, dynamic>>.from(
        data['reminder_times_status'] ?? [],
      ),
      userId: data['user_id'] ?? '',
      medicineId: data['medicine_id'] ?? '',
    );
  }
}