// services/get_medicine_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../features/add_medicine/data/models/reminder_model.dart';
import '../models/medicine_model.dart';
import '../models/reminder_status.dart';

class GetMedicineService {
  final _firestore = FirebaseFirestore.instance;
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  Future<List<MedicineModel>> getAllMedicines() async {
    if (uid == null || uid!.isEmpty) {
      print("User not logged in");
      return [];
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    try {
      print("جاري جلب أدوية اليوم فقط للمستخدم: $uid");

      final snapshot = await _firestore
          .collection('user_medicines')
          .where('user_id', isEqualTo: uid)
          .get();

      final List<MedicineModel> allMedicines = [];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final id = doc.id;

        try {
          final reminderTimes = (data['custom_times'] as List<dynamic>?)
              ?.map((e) => ReminderModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
              [];

          final reminderTimesStatus = (data['reminder_times_status'] as List<dynamic>?)
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

          allMedicines.add(medicine);
        } catch (e) {
          print("فشل تحليل دواء $id: $e");
          continue;
        }
      }

      // فلترة: بس الأدوية اللي ليها جرعة النهارده
      final todayMedicines = allMedicines.where((med) {
        return med.reminderTimesStatus.any((r) {
          final d = r.reminderTime.toDate();
          return d.year == today.year && d.month == today.month && d.day == today.day;
        });
      }).toList();

      if (todayMedicines.isEmpty) {
        print("لا توجد أدوية لها جرعات اليوم");
        return [];
      }

      // ترتيب حسب أقرب جرعة waiting
      todayMedicines.sort((a, b) {
        DateTime? nextA = a.reminderTimesStatus
            .where((r) => r.status == "waiting" && r.reminderTime.toDate().day == today.day)
            .map((r) => r.reminderTime.toDate())
            .cast<DateTime?>()
            .firstOrNull;

        DateTime? nextB = b.reminderTimesStatus
            .where((r) => r.status == "waiting" && r.reminderTime.toDate().day == today.day)
            .map((r) => r.reminderTime.toDate())
            .cast<DateTime?>()
            .firstOrNull;

        if (nextA == null && nextB == null) return 0;
        if (nextA == null) return 1;
        if (nextB == null) return -1;
        return nextA.compareTo(nextB);
      });

      print("تم جلب ${todayMedicines.length} دواء لليوم فقط:");
      for (var m in todayMedicines) {
        print("• ${m.medicineName} → ${m.currentStatus}");
      }

      return todayMedicines;
    } catch (e, s) {
      print("خطأ في جلب الأدوية: $e");
      print(s);
      return [];
    }
  }

  Future<void> deleteMedicine(String id) async {
    if (uid == null) return;
    await _firestore.collection('user_medicines').doc(id).delete();
  }
}