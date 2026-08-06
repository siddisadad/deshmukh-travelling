import 'package:flutter/material.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Help & Support'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tour Leader',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    'Sheikh Farooq Ahmed',
                    'Religious Guide & Group Leader',
                    '+966 50 123 4567',
                    Icons.person,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Agency Support',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    'Deshmukh Travels HQ',
                    '24/7 Operations Desk',
                    '+1 800 555 0199',
                    Icons.business,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Emergency Contacts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildEmergencyItem('Ambulance (Saudi)', '997'),
                  _buildEmergencyItem('Police (Saudi)', '999'),
                  _buildEmergencyItem('Civil Defense', '998'),

                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat),
                    label: const Text('Chat with Support'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06402B),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(String name, String role, String phone, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFF06402B).withValues(alpha: 0.1),
              child: Icon(icon, color: const Color(0xFF06402B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(role, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(phone, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.phone, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyItem(String title, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(number, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
        ],
      ),
    );
  }
}
