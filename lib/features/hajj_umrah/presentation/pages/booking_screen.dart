import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/hajj_package.dart';
import '../providers/hajj_providers.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HajjBookingScreen extends ConsumerStatefulWidget {
  final HajjPackage? package;

  const HajjBookingScreen({super.key, this.package});

  @override
  ConsumerState<HajjBookingScreen> createState() => _HajjBookingScreenState();
}

class _HajjBookingScreenState extends ConsumerState<HajjBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  int _pilgrimCount = 1;

  @override
  Widget build(BuildContext context) {
    final HajjPackage? package = widget.package ?? ref.watch(selectedPackageProvider);

    if (package == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No package selected')),
      );
    }

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Pilgrim Details'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${package.startDate.day}/${package.startDate.month}/${package.startDate.year}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const Divider(height: 40),

                    const Text(
                      'Number of Pilgrims',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildCounterButton(Icons.remove, () {
                          if (_pilgrimCount > 1) setState(() => _pilgrimCount--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            '$_pilgrimCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        _buildCounterButton(Icons.add, () {
                          setState(() => _pilgrimCount++);
                        }),
                      ],
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'Primary Pilgrim Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('Full Name (as per Passport)', Icons.person),
                    const SizedBox(height: 16),
                    _buildTextField('Passport Number', Icons.assignment_ind),
                    const SizedBox(height: 16),
                    _buildTextField('Email Address', Icons.email, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildTextField('Phone Number', Icons.phone, keyboardType: TextInputType.phone),

                    const SizedBox(height: 40),

                    Card(
                      color: const Color(0xFF06402B).withValues(alpha: 0.05),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildSummaryRow('Price per person', '\$${package.price}'),
                            const SizedBox(height: 8),
                            _buildSummaryRow('Total Pilgrims', 'x$_pilgrimCount'),
                            const Divider(height: 24),
                            _buildSummaryRow('Total Amount', '\$${package.price * _pilgrimCount}', isTotal: true),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showConfirmationDialog();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('CONFIRM BOOKING', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF06402B)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF06402B)),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF06402B)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF06402B), width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF06402B) : Colors.black,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Successful'),
        content: const Text('Your booking has been received. Our agent will contact you shortly for visa documents.'),
        actions: [
          TextButton(
            onPressed: () {
              context.goNamed('MyJourney');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
