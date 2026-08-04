import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'notifications_model.dart';
export 'notifications_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  static String routeName = 'Notifications';
  static String routePath = '/notifications';

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 24.0,
          ),
          onPressed: () => context.safePop(),
        ),
        title: Text(
          'Notifications',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                font: GoogleFonts.plusJakartaSans(),
                color: Colors.white,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in _model.notifications) {
                  n.isRead = true;
                }
              });
            },
            child: const Text('Mark all as read', style: TextStyle(color: Colors.white70)),
          ),
        ],
        elevation: 0,
      ),
      body: _model.notifications.isEmpty
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
              itemCount: _model.notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = _model.notifications[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      n.isRead = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: n.isRead ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryContainer.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: n.isRead ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).primary.withOpacity(0.3),
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
      case 'booking': return FlutterFlowTheme.of(context).success.withOpacity(0.1);
      case 'offer': return FlutterFlowTheme.of(context).secondary.withOpacity(0.1);
      case 'alert': return FlutterFlowTheme.of(context).error.withOpacity(0.1);
      default: return FlutterFlowTheme.of(context).primary.withOpacity(0.1);
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
