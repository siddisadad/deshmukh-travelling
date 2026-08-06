import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../components/app_header.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../providers/taxi_rental_providers.dart';

class TaxiSearchResultsScreen extends ConsumerWidget {
  final String? from;
  final String? to;

  const TaxiSearchResultsScreen({
    super.key,
    this.from,
    this.to,
  });

  static String routeName = 'TaxiSearchResults';
  static String routePath = '/taxiSearchResults';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableTaxisAsync = ref.watch(availableTaxisProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          AppHeader(
            title: 'Taxis Available',
            bottom: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
              child: Row(
                children: [
                  Icon(Icons.directions_car_rounded, size: 14, color: FlutterFlowTheme.of(context).secondaryText),
                  const SizedBox(width: 8),
                  Text(
                    '${from?.split(',').first ?? 'Origin'} → ${to?.split(',').first ?? 'Dest'}',
                    style: FlutterFlowTheme.of(context).bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: availableTaxisAsync.when(
              data: (result) => result.fold(
                (taxis) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: taxis.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final taxi = taxis[index];
                    return AppCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              taxi.image,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  taxi.vehicleName,
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                        font: GoogleFonts.plusJakartaSans(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  taxi.type,
                                  style: FlutterFlowTheme.of(context).bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star_rounded,
                                        color: FlutterFlowTheme.of(context).warning, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      taxi.rating.toString(),
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${taxi.baseFare.toInt()}',
                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              AppButton(
                                text: 'Book',
                                size: AppButtonSize.small,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Booking ${taxi.vehicleName}...')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
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
}
