import 'package:flutter/material.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class MyJourneyScreen extends StatelessWidget {
  const MyJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Journey Status'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF06402B),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFD4AF37),
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahmed Abdullah',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ID: HT-2026-8892',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Live Journey Timeline',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTimelineItem(context, 'Visa Approved', 'Your Saudi E-Visa has been issued.', '12 May 2026', true, true),
                  _buildTimelineItem(context, 'Payment Confirmed', 'Final installment received.', '10 May 2026', true, false),
                  _buildTimelineItem(context, 'Flight Ticket', 'Tickets will be issued 7 days before departure.', 'Pending', false, false),
                  _buildTimelineItem(context, 'Hotel Voucher', 'Makkah & Madinah vouchers pending.', 'Pending', false, false),
                  _buildTimelineItem(context, 'Departure', 'Ready to fly from JFK International.', '15 Jun 2026', false, false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String title, String desc, String date, bool isDone, bool isFirst) {
    final color = isDone ? const Color(0xFF06402B) : Colors.grey[300]!;
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: isDone ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDone ? FlutterFlowTheme.of(context).primaryText : Colors.grey,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(fontSize: 12, color: FlutterFlowTheme.of(context).secondaryText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(color: FlutterFlowTheme.of(context).secondaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
