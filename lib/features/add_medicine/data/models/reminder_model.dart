class ReminderModel {
  String hour;
  String minute;
  String period;

  ReminderModel({
    required this.hour,
    required this.minute,
    required this.period,
  });

  Map<String, dynamic> toMap() {
    return {
      "hour": hour,
      "minute": minute,
      "period": period,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      hour: map["hour"],
      minute: map["minute"],
      period: map["period"],
    );
  }
}
