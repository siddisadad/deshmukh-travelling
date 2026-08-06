import 'package:flutter/material.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class TravelDocumentsScreen extends StatelessWidget {
  const TravelDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Travel Documents'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDocItem('E-Visa Copy', 'Issued on 12 May 2026', Icons.picture_as_pdf),
                _buildDocItem('Flight E-Ticket', 'Available 7 days before', Icons.flight, isAvailable: false),
                _buildDocItem('Hotel Vouchers', 'Available 7 days before', Icons.hotel, isAvailable: false),
                _buildDocItem('Travel Insurance', 'Issued on 10 May 2026', Icons.security),
                _buildDocItem('Hajj Guide PDF', 'Preparation handbook', Icons.menu_book),
                _buildDocItem('Vaccination Certificate', 'Required for entry', Icons.medical_services),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocItem(String title, String subtitle, IconData icon, {bool isAvailable = true}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF06402B)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: isAvailable
            ? const Icon(Icons.download, color: Color(0xFFD4AF37))
            : const Icon(Icons.lock_clock, color: Colors.grey),
        onTap: isAvailable ? () {
          // Trigger download
        } : null,
      ),
    );
  }
}
