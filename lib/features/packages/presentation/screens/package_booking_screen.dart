import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../auth/firebase_auth/auth_util.dart';
import '../../../../backend/schema/booking_record.dart';
import '../../../../features/bus_booking/presentation/screens/payment_checkout_screen.dart';
import '../../domain/entities/package_record.dart';
import '../providers/package_providers.dart';
import '../../../../l10n/app_localizations.dart';

class HolidayPackageBookingScreen extends ConsumerWidget {
  final PackageRecord package;

  const HolidayPackageBookingScreen({
    super.key,
    required this.package,
  });

  static String routeName = 'PackageBooking';
  static String routePath = '/packageBooking';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final bookingNotifier = ref.read(bookingProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          l10n.bookHoliday,
          style: AppTypography.titleMedium.copyWith(color: AppColors.onPrimary),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    style: AppTypography.headlineMedium.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _sectionTitle(l10n.selectDepartureDate),
                  const SizedBox(height: AppSpacing.md),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: bookingState.selectedDate ??
                            DateTime.now().add(const Duration(days: 14)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        bookingNotifier.setSelectedDate(date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.alternate),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              color: AppColors.primary, size: 20),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            bookingState.selectedDate != null
                                ? DateFormat('dd MMM, yyyy')
                                    .format(bookingState.selectedDate!)
                                : l10n.selectDate,
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _sectionTitle(l10n.numberOfTravelers),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      _counterButton(Icons.remove, () {
                        if (bookingState.travelerCount > 1) {
                          bookingNotifier
                              .setTravelerCount(bookingState.travelerCount - 1);
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl),
                        child: Text(
                          bookingState.travelerCount.toString(),
                          style: AppTypography.headlineMedium,
                        ),
                      ),
                      _counterButton(Icons.add, () {
                        bookingNotifier
                            .setTravelerCount(bookingState.travelerCount + 1);
                      }),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppCard(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.05),
                    hasShadow: false,
                    child: Column(
                      children: [
                        _priceRow(l10n.packagePrice,
                            '₹${package.price.toInt()}'),
                        const SizedBox(height: AppSpacing.sm),
                        _priceRow(l10n.passengers,
                            'x${bookingState.travelerCount}'),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: AppSpacing.md),
                          child: Divider(height: 1),
                        ),
                        _priceRow(
                          l10n.totalAmount,
                          '₹${(package.price * bookingState.travelerCount).toInt()}',
                          isTotal: true,
                        ),
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
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.lg,
        ),
        child: AppButton(
          text: l10n.proceedToPayment,
          isLoading: bookingState.isLoading,
          onPressed: bookingState.selectedDate == null
              ? null
              : () {
                  final totalAmount =
                      package.price * bookingState.travelerCount;
                  final booking = BookingRecord(
                    userId: currentUserUid,
                    busId: 'holiday',
                    busName: package.title,
                    busType: 'Holiday Package',
                    departureCity: '',
                    arrivalCity: '',
                    depTime: '',
                    arrTime: '',
                    seatNumbers: [],
                    passengers: List.generate(
                      bookingState.travelerCount,
                      (index) => Passenger(
                        name: 'Traveler ${index + 1}',
                        age: 25,
                        gender: 'Male',
                      ),
                    ),
                    totalAmount: totalAmount,
                    status: 'pending',
                    timestamp: bookingState.selectedDate ?? DateTime.now(),
                  );

                  context.pushNamed(
                    PaymentCheckoutScreen.routeName,
                    extra: booking,
                  );
                },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)
              : AppTypography.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTypography.headlineMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                )
              : AppTypography.titleMedium,
        ),
      ],
    );
  }
}
