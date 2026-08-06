import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../components/app_header.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../core/design_system/components/app_text_field.dart';
import '../../../../backend/schema/taxi_record.dart';
import '../providers/taxi_rental_providers.dart';

class TaxiBookingScreen extends ConsumerStatefulWidget {
  const TaxiBookingScreen({super.key});

  static String routeName = 'TaxiBooking';
  static String routePath = '/taxiBooking';

  @override
  ConsumerState<TaxiBookingScreen> createState() => _TaxiBookingScreenState();
}

class _TaxiBookingScreenState extends ConsumerState<TaxiBookingScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickupController.text = ref.read(pickupLocationProvider);
      _dropController.text = ref.read(dropLocationProvider);
    });
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableTaxisAsync = ref.watch(availableTaxisProvider);
    final selectedTaxi = ref.watch(selectedTaxiProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Book a Taxi'),
          Container(
            padding: const EdgeInsets.all(16),
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: Column(
              children: [
                AppTextField(
                  controller: _pickupController,
                  label: 'Pickup Location',
                  prefixIcon: Icon(Icons.my_location, color: FlutterFlowTheme.of(context).primary, size: 20),
                  onChanged: (val) => ref.read(pickupLocationProvider.notifier).state = val,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _dropController,
                  label: 'Drop Location',
                  prefixIcon: Icon(Icons.location_on, color: FlutterFlowTheme.of(context).primary, size: 20),
                  onChanged: (val) => ref.read(dropLocationProvider.notifier).state = val,
                ),
              ],
            ),
          ),
          Expanded(
            child: availableTaxisAsync.when(
              data: (result) => result.fold(
                (taxis) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: taxis.length,
                  itemBuilder: (context, index) {
                    final taxi = taxis[index];
                    bool isSelected = selectedTaxi?.id == taxi.id;
                    return _taxiItem(taxi, isSelected);
                  },
                ),
                (exception) => Center(child: Text(exception.message)),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: AppButton(
              text: 'Confirm Booking',
              isDisabled: selectedTaxi == null || _dropController.text.isEmpty,
              isFullWidth: true,
              onPressed: () async {
                final repo = ref.read(taxiRentalRepositoryProvider);
                final result = await repo.bookTaxi(selectedTaxi!, _pickupController.text, _dropController.text);

                if (result.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Taxi booked successfully!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: ${result.exception?.message}')));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _taxiItem(TaxiRecord taxi, bool isSelected) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      backgroundColor: isSelected ? FlutterFlowTheme.of(context).primary.withValues(alpha: 0.05) : FlutterFlowTheme.of(context).secondaryBackground,
      onTap: () => ref.read(selectedTaxiProvider.notifier).state = taxi,
      child: Container(
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: FlutterFlowTheme.of(context).primary) : null,
          borderRadius: BorderRadius.circular(12),
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
