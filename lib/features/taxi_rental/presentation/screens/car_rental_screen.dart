import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../components/app_header.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../backend/schema/rental_record.dart';
import '../providers/taxi_rental_providers.dart';
import 'car_rental_details_screen.dart';

class CarRentalScreen extends ConsumerWidget {
  const CarRentalScreen({super.key});

  static String routeName = 'CarRental';
  static String routePath = '/carRental';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableRentalsAsync = ref.watch(availableRentalsProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Car Rentals'),
          Expanded(
            child: availableRentalsAsync.when(
              data: (result) => result.fold(
                (rentals) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      child: Row(
                        children: [
                          _filterChip(context, 'Type', Icons.directions_car),
                          const SizedBox(width: 8),
                          _filterChip(context, 'Price', Icons.currency_rupee),
                          const SizedBox(width: 8),
                          _filterChip(context, 'Transmission', Icons.settings),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: rentals.length,
                        itemBuilder: (context, index) {
                          final car = rentals[index];
                          return _rentalCard(context, car);
                        },
                      ),
                    ),
                  ],
                ),
                (exception) => Center(child: Text(exception.message)),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Widget _rentalCard(BuildContext context, RentalRecord car) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      onTap: () {
        context.pushNamed(
          CarRentalDetailsScreen.routeName,
          extra: <String, dynamic>{
            'car': car,
          },
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: car.image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 160,
                width: double.infinity,
                color: FlutterFlowTheme.of(context).alternate,
                child: Icon(
                  Icons.directions_car_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(car.vehicleName,
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                                font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold))),
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: FlutterFlowTheme.of(context).warning,
                            size: 16),
                        Text(car.rating.toString(),
                            style: FlutterFlowTheme.of(context).labelSmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _specChip(context, car.type),
                    const SizedBox(width: 8),
                    _specChip(context, car.transmission),
                    const SizedBox(width: 8),
                    _specChip(context, car.fuelType),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price Per Day',
                            style: FlutterFlowTheme.of(context).labelSmall),
                        Text('₹${car.pricePerDay.toInt()}',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                    font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold),
                                    color: FlutterFlowTheme.of(context)
                                        .primary)),
                      ],
                    ),
                    AppButton(
                      text: 'Rent Now',
                      size: AppButtonSize.medium,
                      onPressed: () {
                        context.pushNamed(
                          CarRentalDetailsScreen.routeName,
                          extra: <String, dynamic>{
                            'car': car,
                          },
                        );
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

  Widget _specChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent1.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: FlutterFlowTheme.of(context).labelSmall.override(font: GoogleFonts.inter(), color: FlutterFlowTheme.of(context).primary)),
    );
  }
}
