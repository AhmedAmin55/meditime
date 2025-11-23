class AppNotification {
  final String title;
  final String subtitle;
  final DateTime time;
  final NotificationType type;

  AppNotification({required this.title, required this.subtitle, required this.time, required this.type});
}

enum NotificationType { now, missed, taken }