// models/medicine_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meditime/core/models/reminder_status.dart';
import '../../features/add_medicine/data/models/reminder_model.dart';



class MedicineModel {
  final String id;
  final String medicineName;
  final String specialInstructions;
  final String assignToWho;
  final String dosage;
  final String medicineType;
  final String duration;
  final int durationInDays;
  final String customizeDays;
  final List<ReminderModel> reminderTimes;           // المواعيد الأساسية (08:00 AM, 08:00 PM)
  final List<ReminderStatus> reminderTimesStatus;    // كل جرعة على مدار الأيام + حالتها
  final Timestamp? createdAt;

  // حالة الدواء اليوم (للعرض في الكارت)
  String get currentStatus {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final todayReminders = reminderTimesStatus.where((r) {
      final date = r.reminderTime.toDate();
      return date.year == now.year && date.month == now.month && date.day == now.day;
    }).toList();

    if (todayReminders.isEmpty) return "waiting";

    final hasTaken = todayReminders.any((r) => r.status == "taken");
    final hasMissed = todayReminders.any((r) => r.status == "missed");

    if (hasMissed) return "missed";
    if (hasTaken && todayReminders.length == todayReminders.where((r) => r.status == "taken").length) {
      return "taken";
    }
    return "waiting";
  }

  MedicineModel({
    required this.id,
    required this.medicineName,
    required this.specialInstructions,
    required this.assignToWho,
    required this.dosage,
    required this.medicineType,
    required this.duration,
    required this.durationInDays,
    required this.customizeDays,
    required this.reminderTimes,
    required this.reminderTimesStatus,
    this.createdAt,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json, String docId) {
    final reminderList = json['custom_times'] as List<dynamic>?;
    final statusList = json['reminder_times_status'] as List<dynamic>?;

    return MedicineModel(
      id: docId,
      medicineName: json['medicine_name'] ?? 'غير معروف',
      specialInstructions: json['special_instructions'] ?? '',
      assignToWho: json['assign_to_who'] ?? 'Me',
      dosage: json['dosage'] ?? '',
      medicineType: json['medicine_type'] ?? 'Pills',
      duration: json['duration_in_days']?.toString() ?? '30',
      durationInDays: (json['duration_in_days'] as num?)?.toInt() ?? 30,
      customizeDays: json['custom_day'] ?? 'Everyday',
      createdAt: json['created_at'] as Timestamp?,
      reminderTimes: reminderList
          ?.map((e) => ReminderModel.fromMap(e as Map<String, dynamic>))
          .toList() ??
          [],
      reminderTimesStatus: statusList
          ?.map((e) => ReminderStatus.fromMap(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicine_name': medicineName,
      'special_instructions': specialInstructions,
      'assign_to_who': assignToWho,
      'dosage': dosage,
      'medicine_type': medicineType,
      'duration_in_days': durationInDays,
      'custom_day': customizeDays,
      'custom_times': reminderTimes.map((r) => r.toMap()).toList(),
      'reminder_times_status': reminderTimesStatus.map((r) => r.toMap()).toList(),
      'created_at': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}