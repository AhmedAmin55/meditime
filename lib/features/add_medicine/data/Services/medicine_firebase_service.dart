import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicineFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUserId() async {
    return _auth.currentUser?.uid;
  }

  Future<bool> saveMedicine({
    required String medicineName,
    required String medicineType,
    required String dosage,
    required String assignTo,
    String? specialInstructions,
    required int durationInDays,
    required String durationUnit,
    required String customDay,
    required List<Map<String, dynamic>> reminderTimes,
  }) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        throw Exception('User not logged in');
      }

      DocumentReference medicineDoc = await _firestore
          .collection('medicines')
          .add({
        'name': medicineName,
        'type': medicineType,
      });

      List<Map<String, dynamic>> reminderTimesList = [];
      for (var time in reminderTimes) {
        DateTime now = DateTime.now();
        int hour = int.parse(time['hour']);

        if (time['period'] == 'PM' && hour != 12) {
          hour += 12;
        }
        if (time['period'] == 'AM' && hour == 12) {
          hour = 0;
        }

        DateTime reminderTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          int.parse(time['minute']),
        );

        if (reminderTime.isBefore(now)) {
          reminderTime = reminderTime.add(Duration(days: 1));
        }

        reminderTimesList.add({
          'reminder': Timestamp.fromDate(reminderTime),
          'status': 'waiting',
        });
      }

      List<String> customTimesList = reminderTimes
          .map((time) => '${time['hour']}:${time['minute']} ${time['period']}')
          .toList();

      await _firestore.collection('user_medicines').add({
        'custom_days': [customDay],
        'custom_times': customTimesList,
        'dosage': dosage,
        'duration_in_days': durationInDays,
        'medicine_id': 'medicines/${medicineDoc.id}',
        'reminder_times_status': reminderTimesList,
        'special_instructions': specialInstructions ?? '',
        'user_id': 'users/$userId',
      });

      return true;
    } catch (e) {
      print('Error saving medicine: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getUserMedicines() async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return [];
      }

      QuerySnapshot snapshot = await _firestore
          .collection('user_medicines')
          .where('user_id', isEqualTo: 'users/$userId')
          .get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      print('Error getting medicines: $e');
      return [];
    }
  }

  Future<bool> deleteMedicine(String medicineId) async {
    try {
      await _firestore.collection('user_medicines').doc(medicineId).delete();
      return true;
    } catch (e) {
      print('Error deleting medicine: $e');
      return false;
    }
  }

  Future<bool> updateMedicineStatus({
    required String medicineId,
    required int reminderIndex,
    required String newStatus,
  }) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('user_medicines')
          .doc(medicineId)
          .get();

      if (!doc.exists) return false;

      List<dynamic> reminderTimes = doc.get('reminder_times_status');

      if (reminderIndex < reminderTimes.length) {
        reminderTimes[reminderIndex]['status'] = newStatus;

        await _firestore
            .collection('user_medicines')
            .doc(medicineId)
            .update({'reminder_times_status': reminderTimes});

        return true;
      }

      return false;
    } catch (e) {
      print('Error updating status: $e');
      return false;
    }
  }
}