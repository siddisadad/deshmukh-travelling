import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../components/app_header.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../backend/schema/rental_record.dart';
import '../providers/taxi_rental_providers.dart';

class CarRentalDetailsScreen extends ConsumerWidget {
  final RentalRecord car;

  const CarRentalDetailsScreen({super.key, required this.car});

  static String routeName = 'CarRentalDetails';
  static String routePath = '/carRentalDetails';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Rental Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: car.image,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      height: 240,
                      width: double.infinity,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Icon(Icons.directions_car_rounded, size: 64, color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              car.vehicleName,
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).warning, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  car.rating.toString(),
                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${car.type} • ${car.capacity} Seater',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(),
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Specifications',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                              ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _specItem(context, Icons.settings_suggest_rounded, 'Transmission', car.transmission),
                            _specItem(context, Icons.local_gas_station_rounded, 'Fuel Type', car.fuelType),
                            _specItem(context, Icons.airline_seat_recline_normal_rounded, 'Capacity', '${car.capacity} Adults'),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Rental Terms',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                              ),
                        ),
                        const SizedBox(height: 12),
                        _termItem(context, 'Refundable Security Deposit: ₹5,000'),
                        _termItem(context, 'Fuel charges extra as per usage'),
                        _termItem(context, 'Daily limit: 250 km (₹15/km extra)'),
                        _termItem(context, 'Valid DL and Aadhar card required'),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: const Color(0x1A000000),
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹${car.pricePerDay.toInt()}',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                ),
                Text('/ per day', style: FlutterFlowTheme.of(context).labelSmall),
              ],
            ),
            AppButton(
              text: 'Book Rental',
              onPressed: () async {
                final repo = ref.read(taxiRentalRepositoryProvider);
                final result = await repo.bookRental(car);
                if (result.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Car rental booked successfully!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${result.exception?.message}')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _specItem(BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: FlutterFlowTheme.of(context).primary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(value, style: FlutterFlowTheme.of(context).bodySmall.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold))),
        Text(label, style: TextStyle(fontSize: 10, color: FlutterFlowTheme.of(context).secondaryText)),
      ],
    );
  }

  Widget _termItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 16, color: FlutterFlowTheme.of(context).secondaryText),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: FlutterFlowTheme.of(context).bodySmall)),
        ],
      ),
    );
  }
}
