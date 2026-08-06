class NotificationItem {
  final String title;
  final String message;
  final DateTime timestamp;
  final String type;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}
