import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../index.dart';

class BookingConfirmationTicketScreen extends StatelessWidget {
  final BookingRecord booking;

  const BookingConfirmationTicketScreen({super.key, required this.booking});

  static String routeName = 'BookingConfirmationTicket';
  static String routePath = '/bookingConfirmationTicket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildSuccessHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _buildTicketCard(context),
                const SizedBox(height: AppSpacing.lg),
                _buildActions(context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AppButton(
              text: AppLocalizations.of(context)!.backToHome,
              onPressed: () => context.goNamed(HomeDashboardScreen.routeName),
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xxl, AppSpacing.lg, AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppRadius.xxl), bottomRight: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 64),
          const SizedBox(height: AppSpacing.md),
          Text(AppLocalizations.of(context)!.bookingConfirmed, style: AppTypography.headlineMedium.copyWith(color: Colors.white)),
          Text('Your ride is ready!', style: AppTypography.bodyMedium.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BOOKING ID', style: AppTypography.labelSmall),
              Text(booking.id?.toUpperCase() ?? '', style: AppTypography.titleSmall.copyWith(color: AppColors.primary)),
            ],
          ),
          const Divider(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _locationInfo('From', booking.departureCity, booking.depTime),
              const Icon(Icons.arrow_forward_rounded, color: AppColors.textSecondary),
              _locationInfo('To', booking.arrivalCity, booking.arrTime),
            ],
          ),
          const Divider(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Seats: ${booking.seatNumbers.join(', ')}', style: AppTypography.bodyMedium),
              Text('Amount: ₹${booking.totalAmount.toInt()}', style: AppTypography.titleSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationInfo(String label, String city, String time) {
    return Column(
      crossAxisAlignment: label == 'To' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelSmall),
        Text(city.split(',').first, style: AppTypography.titleMedium),
        Text(time, style: AppTypography.bodySmall),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _actionBtn(Icons.download_rounded, 'Download')),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _actionBtn(Icons.share_rounded, 'Share')),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label) {
    return AppCard(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}
