import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../providers/my_trips_providers.dart';
import '../../../../core/design_system/components/app_button.dart';

import '../../../../auth/firebase_auth/auth_util.dart';

class MyTripsScreen extends ConsumerWidget {
  final String? userId;

  const MyTripsScreen({super.key, this.userId});

  static const String routeName = 'MyTrips';
  static const String routePath = '/myTrips';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final effectiveUserId = userId ?? currentUserUid;
    final bookingsAsync = ref.watch(userBookingsProvider(effectiveUserId));

    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips', style: AppTypography.titleMedium),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: bookingsAsync.when(
        data: (bookings) => bookings.isEmpty
            ? const Center(child: Text('No trips found'))
            : ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: bookings.length,
                itemBuilder: (context, index) => _bookingListItem(bookings[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _bookingListItem(dynamic booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(booking.serviceName, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
              _statusChip(booking.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(booking.serviceType, style: AppTypography.labelMedium),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${booking.from} to ${booking.to}', style: AppTypography.bodyMedium),
              Text('₹${booking.amount}', style: AppTypography.titleMedium.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (booking.status == 'upcoming')
            AppButton(
              text: 'Cancel Trip',
              onPressed: () {},
              variant: AppButtonVariant.outline,
              size: AppButtonSize.small,
            ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final color = status == 'upcoming' ? AppColors.info : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
