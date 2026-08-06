import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../providers/profile_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static String routeName = 'Notifications';
  static String routePath = '/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          AppHeader(
            title: 'Notifications',
            actionWidget: TextButton(
              onPressed: () => ref.read(notificationsProvider.notifier).markAllAsRead(),
              child: Text(
                'Mark all as read',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(),
                      color: FlutterFlowTheme.of(context).primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Expanded(
            child: notificationsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (notifications) => notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_off_outlined, size: 64, color: FlutterFlowTheme.of(context).secondaryText),
                          const SizedBox(height: 16),
                          Text('No notifications yet', style: FlutterFlowTheme.of(context).bodyLarge),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final n = notifications[index];
                        return InkWell(
                          onTap: () => ref.read(notificationsProvider.notifier).markAsRead(n.id),
                          child: Container(
                            decoration: BoxDecoration(
                              color: n.isRead ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryContainer.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: n.isRead ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).primary.withValues(alpha: 0.3),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _getIconBgColor(n.type, context),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(_getIcon(n.type), color: _getIconColor(n.type, context), size: 20),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(n.title, style: FlutterFlowTheme.of(context).bodyLarge.override(
                                            font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                          )),
                                          if (!n.isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primary, shape: BoxShape.circle),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(n.message, style: FlutterFlowTheme.of(context).bodyMedium),
                                      const SizedBox(height: 8),
                                      Text(timeago.format(n.timestamp), style: FlutterFlowTheme.of(context).labelSmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'booking': return Icons.confirmation_number_rounded;
      case 'offer': return Icons.local_offer_rounded;
      case 'alert': return Icons.warning_rounded;
      default: return Icons.notifications_rounded;
    }
  }

  Color _getIconBgColor(String type, BuildContext context) {
    switch (type) {
      case 'booking': return FlutterFlowTheme.of(context).success.withValues(alpha: 0.1);
      case 'offer': return FlutterFlowTheme.of(context).secondary.withValues(alpha: 0.1);
      case 'alert': return FlutterFlowTheme.of(context).error.withValues(alpha: 0.1);
      default: return FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1);
    }
  }

  Color _getIconColor(String type, BuildContext context) {
    switch (type) {
      case 'booking': return FlutterFlowTheme.of(context).success;
      case 'offer': return FlutterFlowTheme.of(context).secondary;
      case 'alert': return FlutterFlowTheme.of(context).error;
      default: return FlutterFlowTheme.of(context).primary;
    }
  }
}
