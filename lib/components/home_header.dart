import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HomeHeader extends StatelessWidget {
  final String appTitle;
  final String subtitle;
  final VoidCallback onNotificationTap;
  final Widget child;

  const HomeHeader({
    super.key,
    required this.appTitle,
    required this.subtitle,
    required this.onNotificationTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
          bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appTitle,
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                            ),
                            color: FlutterFlowTheme.of(context).onPrimary,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1.3,
                          ),
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
                    Text(
                      subtitle,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(),
                            color: FlutterFlowTheme.of(context).onPrimary80,
                            lineHeight: 1.6,
                          ),
                    ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.1, end: 0),
                  ].divide(const SizedBox(height: 4.0)),
                ),
                FlutterFlowIconButton(
                  borderRadius: 9999.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).onPrimary10,
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: FlutterFlowTheme.of(context).onPrimary,
                    size: 24.0,
                  ),
                  onPressed: onNotificationTap,
                ).animate().scale(duration: 400.ms, delay: 200.ms),
              ],
            ),
            const SizedBox(height: 16.0),
            child,
          ],
        ),
      ),
    );
  }
}
