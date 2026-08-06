import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../auth/firebase_auth/auth_util.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../components/app_header.dart';
import '../../../../index.dart';
import '../providers/hotel_providers.dart';

class HotelBookingConfirmationScreen extends ConsumerWidget {
  final HotelRecord hotel;
  final RoomRecord room;

  const HotelBookingConfirmationScreen({
    super.key,
    required this.hotel,
    required this.room,
  });

  static String routeName = 'HotelBookingConfirmation';
  static String routePath = '/hotelBookingConfirmation';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(hotelBookingNotifierProvider);

    ref.listen(hotelBookingNotifierProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hotel booking successful!')),
        );
        context.goNamed(HomeDashboardScreen.routeName);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: 'Booking Confirmation'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          child: CachedNetworkImage(
                            imageUrl: hotel.images.first,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hotel.name, style: AppTypography.titleSmall),
                              Text(hotel.location, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: 4),
                              Text(
                                room.type,
                                style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Booking Details', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  _DetailRow(label: 'Check-in', value: '15 Aug, 2026 (12:00 PM)'),
                  _DetailRow(label: 'Check-out', value: '16 Aug, 2026 (11:00 AM)'),
                  _DetailRow(label: 'Guests', value: '2 Adults'),
                  _DetailRow(label: 'Duration', value: '1 Night'),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Fare Details', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  _FareRow(label: 'Room Charges (1 Night)', value: '₹${room.price.toStringAsFixed(0)}'),
                  _FareRow(label: 'Taxes & Fees', value: '₹${(room.price * 0.12).toStringAsFixed(0)}'),
                  const Divider(height: AppSpacing.lg),
                  _FareRow(label: 'Total Amount', value: '₹${(room.price * 1.12).toStringAsFixed(0)}', isTotal: true),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppButton(
              text: 'Proceed to Pay',
              isFullWidth: true,
              isLoading: bookingState.isLoading,
              onPressed: () {
                final booking = HotelBookingRecord(
                  id: '',
                  userId: currentUserUid,
                  hotelId: hotel.id,
                  roomId: room.id,
                  checkIn: DateTime.now().add(const Duration(days: 7)),
                  checkOut: DateTime.now().add(const Duration(days: 8)),
                  totalPrice: room.price * 1.12,
                  status: 'confirmed',
                  guestCount: 2,
                  createdAt: DateTime.now(),
                );

                ref.read(hotelBookingNotifierProvider.notifier).createBooking(booking);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _FareRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _FareRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? AppTypography.titleSmall : AppTypography.labelMedium.copyWith(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: isTotal
                ? AppTypography.titleLarge.copyWith(color: AppColors.primary)
                : AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }
}
