import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../components/app_header.dart';
import '../../../../backend/schema/booking_record.dart';
import '../providers/booking_providers.dart';
import '../../../../auth/firebase_auth/auth_util.dart';
import 'package:go_router/go_router.dart';
import 'booking_confirmation_ticket_screen.dart';

class PaymentCheckoutScreen extends ConsumerStatefulWidget {
  final BookingRecord? booking;

  const PaymentCheckoutScreen({super.key, this.booking});

  static String routeName = 'PaymentCheckout';
  static String routePath = '/paymentCheckout';

  @override
  ConsumerState<PaymentCheckoutScreen> createState() => _PaymentCheckoutScreenState();
}

class _PaymentCheckoutScreenState extends ConsumerState<PaymentCheckoutScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingFlowProvider);

    final displayBooking = widget.booking ?? BookingRecord(
      userId: currentUserUid,
      busId: bookingState.selectedBus?.id ?? '',
      busName: bookingState.selectedBus?.name ?? '',
      busType: bookingState.selectedBus?.type ?? '',
      departureCity: bookingState.selectedBus?.departureCity ?? '',
      arrivalCity: bookingState.selectedBus?.arrivalCity ?? '',
      depTime: bookingState.selectedBus?.depTime ?? '',
      arrTime: bookingState.selectedBus?.arrTime ?? '',
      seatNumbers: bookingState.selectedSeats,
      passengers: bookingState.passengers,
      totalAmount: bookingState.totalAmount,
      status: 'Confirmed',
      timestamp: DateTime.now(),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: 'Payment'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _buildBookingSummary(displayBooking),
                const SizedBox(height: AppSpacing.lg),
                _buildPriceDetails(displayBooking),
                const SizedBox(height: AppSpacing.lg),
                _buildPaymentMethods(),
              ],
            ),
          ),
          _buildBottomBar(context, ref, displayBooking),
        ],
      ),
    );
  }

  Widget _buildBookingSummary(BookingRecord booking) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(booking.busName, style: AppTypography.titleMedium.copyWith(color: AppColors.primary)),
          if (booking.departureCity.isNotEmpty)
            Text('${booking.departureCity.split(',').first} → ${booking.arrivalCity.split(',').first}', style: AppTypography.bodyMedium),
          const Divider(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (booking.seatNumbers.isNotEmpty)
                Text('Seats: ${booking.seatNumbers.join(', ')}', style: AppTypography.bodySmall),
              Text('${booking.passengers.length} Passengers', style: AppTypography.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails(BookingRecord booking) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price Details', style: AppTypography.titleSmall),
          const SizedBox(height: AppSpacing.md),
          _priceRow('Base Fare', '₹${booking.totalAmount.toInt()}'),
          _priceRow('Taxes & Fees', '₹0'),
          const Divider(height: AppSpacing.lg),
          _priceRow('Total Amount', '₹${booking.totalAmount.toInt()}', isTotal: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? AppTypography.titleMedium : AppTypography.bodyMedium),
          Text(value, style: isTotal ? AppTypography.titleMedium.copyWith(color: AppColors.primary) : AppTypography.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Payment Method', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: ListTile(
            leading: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
            title: const Text('Deshmukh Wallet'),
            trailing: const Icon(Icons.radio_button_checked_rounded, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, BookingRecord booking) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: SafeArea(
        child: AppButton(
          text: 'Pay Now',
          isLoading: isLoading,
          onPressed: () async {
            setState(() => isLoading = true);
            try {
              final repository = ref.read(busRepositoryProvider);
              final result = await repository.createBooking(booking);

              result.fold(
                (data) {
                  context.pushNamed(BookingConfirmationTicketScreen.routeName, extra: data);
                },
                (exception) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${exception.message}')));
                },
              );
            } finally {
              setState(() => isLoading = false);
            }
          },
        ),
      ),
    );
  }
}

