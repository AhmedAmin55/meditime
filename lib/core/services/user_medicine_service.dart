// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import '../../features/add_medicine/data/models/reminder_model.dart';
import '../models/medicine_model.dart';
import '../models/reminder_status.dart';

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
    if (normalizedCustomDay == "everyday" ||
        normalizedCustomDay.contains("كل يوم")) {
      allowedWeekdays = {1, 2, 3, 4, 5, 6, 7};
    } else {
      final Map<String, int> dayMap = {
        "sunday": DateTime.sunday,
        "الأحد": DateTime.sunday,
        "monday": DateTime.monday,
        "الإثنين": DateTime.monday,
        "tuesday": DateTime.tuesday,
        "الثلاثاء": DateTime.tuesday,
        "wednesday": DateTime.wednesday,
        "الأربعاء": DateTime.wednesday,
        "thursday": DateTime.thursday,
        "الخميس": DateTime.thursday,
        "friday": DateTime.friday,
        "الجمعة": DateTime.friday,
        "saturday": DateTime.saturday,
        "السبت": DateTime.saturday,
      };
      for (var entry in dayMap.entries) {
        if (normalizedCustomDay.contains(entry.key)) {
          allowedWeekdays.add(entry.value);
        }
      }
      if (allowedWeekdays.isEmpty) allowedWeekdays = {1, 2, 3, 4, 5, 6, 7};
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

  Future<List<MedicineModel>> getAllMedicines() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final snapshot = await _firestore
        .collection('user_medicines')
        .where('user_id', isEqualTo: _uid)
        .get();

    final List<MedicineModel> allMedicines = [];

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final id = doc.id;

      final reminderTimes =
          (data['custom_times'] as List<dynamic>?)
              ?.map((e) => ReminderModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [];

      final reminderTimesStatus =
          (data['reminder_times_status'] as List<dynamic>?)
              ?.map((e) => ReminderStatus.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [];

      final medicine = MedicineModel(
        id: id,
        medicineName: data['medicine_name'] ?? 'غير معروف',
        specialInstructions: data['special_instructions'] ?? '',
        assignToWho: data['assign_to_who'] ?? 'Me',
        dosage: data['dosage'] ?? '',
        medicineType: data['medicine_type'] ?? 'Pills',
        duration: (data['duration_in_days'] ?? 30).toString(),
        durationInDays: (data['duration_in_days'] as num?)?.toInt() ?? 30,
        customizeDays: data['custom_day'] ?? 'Everyday',
        reminderTimes: reminderTimes,
        reminderTimesStatus: reminderTimesStatus,
        createdAt: data['created_at'] as Timestamp?,
      );

      final hasTodayDose = medicine.reminderTimesStatus.any((r) {
        final d = r.reminderTime.toDate();
        return d.year == today.year &&
            d.month == today.month &&
            d.day == today.day;
      });

      if (hasTodayDose) allMedicines.add(medicine);
    }

    allMedicines.sort((a, b) {
      final nextA = a.reminderTimesStatus
          .where((r) => r.status == "waiting")
          .map((r) => r.reminderTime.toDate())
          .firstOrNull;

      final nextB = b.reminderTimesStatus
          .where((r) => r.status == "waiting")
          .map((r) => r.reminderTime.toDate())
          .firstOrNull;

      if (nextA == null) return 1;
      if (nextB == null) return -1;
      return nextA.compareTo(nextB);
    });

    return allMedicines;
  }

  Future<void> deleteMedicine(String id) async {
    await _firestore.collection('user_medicines').doc(id).delete();
  }
}
