import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AiAssistantFab extends StatelessWidget {
  final VoidCallback onTap;

  const AiAssistantFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      backgroundColor: FlutterFlowTheme.of(context).primary,
      icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
      label: Text(
        'Travel AI',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 4.0,
    );
  }
}
