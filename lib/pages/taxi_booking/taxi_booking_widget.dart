import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import '../../backend/schema/taxi_record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'taxi_booking_model.dart';

class TaxiBookingWidget extends StatefulWidget {
  const TaxiBookingWidget({super.key});

  static String routeName = 'TaxiBooking';
  static String routePath = '/taxiBooking';

  @override
  State<TaxiBookingWidget> createState() => _TaxiBookingWidgetState();
}

class _TaxiBookingWidgetState extends State<TaxiBookingWidget> {
  late TaxiBookingModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaxiBookingModel());
    _model.fetchTaxis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text('Book a Taxi', style: TextStyle(color: Colors.white)),
        leading: FlutterFlowIconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: Column(
              children: [
                _locationInput(Icons.my_location, 'Pickup', _model.pickupLocation, true),
                const SizedBox(height: 12),
                _locationInput(Icons.location_on, 'Drop', _model.dropLocation, false),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _model.availableTaxis.length,
              itemBuilder: (context, index) {
                final taxi = _model.availableTaxis[index];
                bool isSelected = _model.selectedTaxi?.id == taxi.id;
                return _taxiItem(taxi, isSelected);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: ButtonWidget(
              content: 'Confirm Booking',
              variant: 'primary',
              size: 'large',
              fullWidth: true,
              disabled: _model.selectedTaxi == null,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Taxi booked successfully!')));
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationInput(IconData icon, String label, String value, bool isPickup) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: FlutterFlowTheme.of(context).primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: FlutterFlowTheme.of(context).labelSmall),
                Text(value.isEmpty ? 'Enter $label Location' : value,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: value.isEmpty ? FlutterFlowTheme.of(context).secondaryText : FlutterFlowTheme.of(context).primaryText,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _taxiItem(TaxiRecord taxi, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _model.selectedTaxi = taxi),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? FlutterFlowTheme.of(context).primary.withValues(alpha: 0.05) : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate),
        ),
        child: Row(
          children: [
            CachedNetworkImage(imageUrl: taxi.image, width: 80, height: 60, fit: BoxFit.contain),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taxi.vehicleName, style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                  Text('${taxi.type} • ${taxi.capacity} Seats', style: FlutterFlowTheme.of(context).labelSmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${taxi.baseFare.toInt()}', style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold), color: FlutterFlowTheme.of(context).primaryText)),
                Text('Base Fare', style: FlutterFlowTheme.of(context).labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
