import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// core/services/user_medicine_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMedicineService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addUserMedicine({
    required String medicineName,
    required String specialInstructions,
    required String assignToWho,
    required String medicineType,
    required String dosage,
    required int durationInDays,
    required String customDay,
    required List<Map<String, dynamic>> customTimes,
  }) async {
    List<Map<String, dynamic>> remindersStatus = [];

    final String normalizedCustomDay = customDay.toLowerCase().trim();

    Set<int> allowedWeekdays = {};
    if (normalizedCustomDay == "everyday") {
      allowedWeekdays = {1, 2, 3, 4, 5, 6, 7};
    } else if (normalizedCustomDay.contains("sunday") || normalizedCustomDay.contains("الأحد")) {
      allowedWeekdays.add(DateTime.sunday);
    } else if (normalizedCustomDay.contains("monday") || normalizedCustomDay.contains("الإثنين")) {
      allowedWeekdays.add(DateTime.monday);
    } else if (normalizedCustomDay.contains("tuesday") || normalizedCustomDay.contains("الثلاثاء")) {
      allowedWeekdays.add(DateTime.tuesday);
    } else if (normalizedCustomDay.contains("wednesday") || normalizedCustomDay.contains("الأربعاء")) {
      allowedWeekdays.add(DateTime.wednesday);
    } else if (normalizedCustomDay.contains("thursday") || normalizedCustomDay.contains("الخميس")) {
      allowedWeekdays.add(DateTime.thursday);
    } else if (normalizedCustomDay.contains("friday") || normalizedCustomDay.contains("الجمعة")) {
      allowedWeekdays.add(DateTime.friday);
    } else if (normalizedCustomDay.contains("saturday") || normalizedCustomDay.contains("السبت")) {
      allowedWeekdays.add(DateTime.saturday);
    } else {
      allowedWeekdays = {1, 2, 3, 4, 5, 6, 7};
    }

    for (var time in customTimes) {
      String hourStr = (time['hour'] ?? '').toString().trim();
      String minuteStr = (time['minute'] ?? '').toString().trim();
      String period = (time['period'] ?? 'AM').toString().toUpperCase();

      if (hourStr.isEmpty || minuteStr.isEmpty) continue;

      int hour = int.tryParse(hourStr) ?? 12;
      int minute = int.tryParse(minuteStr) ?? 0;
      hour = hour.clamp(1, 12);
      minute = minute.clamp(0, 59);

      if (period == "PM" && hour != 12) hour += 12;
      if (period == "AM" && hour == 12) hour = 0;

      DateTime startDate = DateTime.now();

      for (int i = 0; i < durationInDays; i++) {
        DateTime currentDay = startDate.add(Duration(days: i));

        if (!allowedWeekdays.contains(currentDay.weekday)) continue;

        DateTime reminderDateTime = DateTime(
          currentDay.year,
          currentDay.month,
          currentDay.day,
          hour,
          minute,
        );

        if (reminderDateTime.isBefore(DateTime.now())) {
          reminderDateTime = reminderDateTime.add(const Duration(days: 1));
        }

        remindersStatus.add({
          "reminder": Timestamp.fromDate(reminderDateTime),
          "status": "waiting",
        });
      }
    }

    await _firestore.collection('user_medicines').add({
      "user_id": _uid,
      "medicine_name": medicineName,
      "special_instructions": specialInstructions,
      "assign_to_who": assignToWho,
      "medicine_type": medicineType,
      "dosage": dosage,
      "duration_in_days": durationInDays,
      "custom_day": customDay,
      "custom_times": customTimes,
      "reminder_times_status": remindersStatus,
      "created_at": FieldValue.serverTimestamp(),
    });
  }
}