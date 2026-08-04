import '/flutter_flow/flutter_flow_util.dart';
import 'notifications_widget.dart' show NotificationsWidget;
import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final String type; // 'booking', 'offer', 'alert'
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

class NotificationsModel extends FlutterFlowModel<NotificationsWidget> {
  List<NotificationItem> notifications = [];

  @override
  void initState(BuildContext context) {
    // Mock notifications
    notifications = [
      NotificationItem(
        id: '1',
        title: 'Booking Confirmed!',
        message: 'Your trip to Pune (DT-9928471) is confirmed for tomorrow.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'booking',
      ),
      NotificationItem(
        id: '2',
        title: '20% OFF Special Offer',
        message: 'Use code FLASHPRO on your next booking to get 20% instant discount.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: 'offer',
      ),
      NotificationItem(
        id: '3',
        title: 'Bus Delayed',
        message: 'Your bus MH-12-AS-1234 is delayed by 15 minutes due to traffic.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: 'alert',
        isRead: true,
      ),
    ];
  }

  @override
  void dispose() {}
}
