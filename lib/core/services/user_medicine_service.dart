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
    required List<Map<String, dynamic>> customTimes, // من uiRows
  }) async {
    List<Map<String, dynamic>> remindersStatus = [];

    // تنظيف بسيط وسريع للتوقيتات
    for (var time in customTimes) {
      String hourStr = (time['hour'] ?? '').toString().trim();
      String minuteStr = (time['minute'] ?? '').toString().trim();
      String period = (time['period'] ?? 'AM').toString();

      if (hourStr.isEmpty || minuteStr.isEmpty) continue;

      int hour = int.tryParse(hourStr) ?? 12;
      int minute = int.tryParse(minuteStr) ?? 0;
      if (hour < 1 || hour > 12) hour = 12;
      minute = minute.clamp(0, 59);

      if (period == "PM" && hour != 12) hour += 12;
      if (period == "AM" && hour == 12) hour = 0;

      DateTime now = DateTime.now();
      for (int i = 0; i < durationInDays; i++) {
        DateTime reminderDate = DateTime(now.year, now.month, now.day + i, hour, minute);

        // تحقق من اليوم لو مش Everyday
        if (customDay != "Everyday") {
          String dayName = DateTime(reminderDate.year, reminderDate.month, reminderDate.day)
              .weekday
              .toString();
          List<String> days = ["7","1","2","3","4","5","6"]; // Sun=7, Mon=1,...
          String dayKey = days[int.parse(dayName)-1];
          if (!customDay.toLowerCase().contains([
            "sunday","monday","tuesday","wednesday","thursday","friday","saturday"
          ][int.parse(dayName)-1])) continue;
        }

        if (reminderDate.isBefore(DateTime.now())) {
          reminderDate = reminderDate.add(const Duration(days: 1));
        }

        remindersStatus.add({
          "reminder": Timestamp.fromDate(reminderDate),
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