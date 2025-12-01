// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderStatus {
  final Timestamp reminderTime;
  final String status;

  ReminderStatus({required this.reminderTime, required this.status});

  factory ReminderStatus.fromMap(Map<String, dynamic> map) {
    return ReminderStatus(
      reminderTime: map['reminder'] as Timestamp,
      status: map['status'] as String? ?? 'waiting',
    );
  }

  Map<String, dynamic> toMap() {
    return {'reminder': reminderTime, 'status': status};
  }
}
