import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../components/seat_widget/seat_widget_widget.dart';
import '../providers/booking_providers.dart';

class BusSeatMap extends ConsumerWidget {
  final String busId;

  const BusSeatMap({super.key, required this.busId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedSeatsAsync = ref.watch(bookedSeatsProvider(busId));
    final bookingState = ref.watch(bookingFlowProvider);
    final bookingNotifier = ref.read(bookingFlowProvider.notifier);

    return bookedSeatsAsync.when(
      data: (bookedSeats) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.alternate),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              for (int i = 0; i < 6; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bus Features (Mocking layout)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Icon(_getFeatureIcon(i), size: 16, color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      // Seats
                      Row(
                        children: [
                          for (int j = 0; j < 4; j++)
                            if (j == 2)
                              const SizedBox(width: AppSpacing.lg)
                            else
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                                child: _buildSeat(
                                  context,
                                  '${i + 1}${String.fromCharCode(65 + j)}',
                                  bookedSeats,
                                  bookingState.selectedSeats,
                                  bookingNotifier,
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  IconData _getFeatureIcon(int index) {
    if (index == 0) return Icons.airline_seat_recline_extra_rounded;
    if (index == 2) return Icons.wc_rounded;
    return Icons.radio_button_checked_rounded;
  }

  Widget _buildSeat(
    BuildContext context,
    String seatNumber,
    List<String> bookedSeats,
    List<String> selectedSeats,
    BookingFlowNotifier notifier,
  ) {
    String status = 'available';
    if (bookedSeats.contains(seatNumber)) {
      status = 'booked';
    } else if (selectedSeats.contains(seatNumber)) {
      status = 'selected';
    }

    return InkWell(
      onTap: status == 'booked' ? null : () => notifier.toggleSeat(seatNumber),
      child: SeatWidgetWidget(
        number: seatNumber,
        status: status,
      ),
    );
  }
}
