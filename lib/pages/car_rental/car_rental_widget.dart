import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import '../../backend/schema/rental_record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'car_rental_model.dart';

class CarRentalWidget extends StatefulWidget {
  const CarRentalWidget({super.key});

  static String routeName = 'CarRental';
  static String routePath = '/carRental';

  @override
  State<CarRentalWidget> createState() => _CarRentalWidgetState();
}

class _CarRentalWidgetState extends State<CarRentalWidget> {
  late CarRentalModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarRentalModel());
    _model.fetchRentals().then((_) => safeSetState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text('Car Rentals', style: TextStyle(color: Colors.white)),
        leading: FlutterFlowIconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: Row(
                    children: [
                      _filterChip('Type', Icons.directions_car),
                      const SizedBox(width: 8),
                      _filterChip('Price', Icons.currency_rupee),
                      const SizedBox(width: 8),
                      _filterChip('Transmission', Icons.settings),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _model.rentals.length,
                    itemBuilder: (context, index) {
                      final car = _model.rentals[index];
                      return _rentalCard(car);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _filterChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label, style: FlutterFlowTheme.of(context).labelSmall),
        ],
      ),
    );
  }

  Widget _rentalCard(RentalRecord car) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x1A000000), offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: CachedNetworkImage(imageUrl: car.image, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(car.vehicleName, style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).warning, size: 16),
                        Text(car.rating.toString(), style: FlutterFlowTheme.of(context).labelSmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _specChip(car.type),
                    const SizedBox(width: 8),
                    _specChip(car.transmission),
                    const SizedBox(width: 8),
                    _specChip(car.fuelType),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${car.pricePerDay.toInt()} / Day', style: FlutterFlowTheme.of(context).titleLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold), color: FlutterFlowTheme.of(context).primary)),
                    ButtonWidget(
                      content: 'Rent Now',
                      variant: 'primary',
                      size: 'medium',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rental confirmed!')));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _specChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: FlutterFlowTheme.of(context).labelSmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).primary)),
    );
  }
}
