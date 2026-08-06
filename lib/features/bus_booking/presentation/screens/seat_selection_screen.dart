import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../components/app_header.dart';
import '../providers/booking_providers.dart';
import '../widgets/bus_seat_map.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'passenger_details_screen.dart';

class SeatSelectionScreen extends ConsumerWidget {
  const SeatSelectionScreen({super.key});

  static String routeName = 'SeatSelection';
  static String routePath = '/seatSelection';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingFlowProvider);
    final bus = bookingState.selectedBus;

    if (bus == null) return const Scaffold(body: Center(child: Text('No bus selected')));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeader(
            title: AppLocalizations.of(context)!.selectSeats,
            onBackPress: () => context.pop(),
            subtitle: '${bus.departureCity.split(',').first} → ${bus.arrivalCity.split(',').first}',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  _buildBusInfo(context, bus),
                  const SizedBox(height: AppSpacing.xl),
                  _buildLegend(context),
                  const SizedBox(height: AppSpacing.xl),
                  BusSeatMap(busId: bus.id),
                ],
              ),
            ),
          ),
          _buildBottomBar(context, ref, bookingState),
        ],
      ),
    );
  }

  Widget _buildBusInfo(BuildContext context, bus) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.alternate),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(AppRadius.sm)),
            child: const Icon(Icons.directions_bus_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bus.name, style: AppTypography.titleMedium),
                Text(bus.type, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: AppColors.secondary, size: 16),
              Text(bus.rating, style: AppTypography.labelSmall.copyWith(color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _legendItem(context, 'Available', AppColors.background),
        _legendItem(context, 'Booked', AppColors.surfaceVariant),
        _legendItem(context, 'Selected', AppColors.primary),
      ],
    );
  }

  Widget _legendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppRadius.xs), border: Border.all(color: AppColors.alternate))),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, bookingState) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: AppShadows.md,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₹${bookingState.totalAmount.toInt()}', style: AppTypography.headlineMedium.copyWith(color: AppColors.primary)),
                Text('${bookingState.selectedSeats.length} Seats', style: AppTypography.labelSmall),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: AppButton(
                text: AppLocalizations.of(context)!.continueBtn,
                isDisabled: bookingState.selectedSeats.isEmpty,
                onPressed: () => context.pushNamed(PassengerDetailsScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
