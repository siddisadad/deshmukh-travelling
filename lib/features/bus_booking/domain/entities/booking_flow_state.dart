import '../../../../backend/schema/bus_record.dart';
import '../../../../backend/schema/booking_record.dart';

class BookingFlowState {
  final BusRecord? selectedBus;
  final List<String> selectedSeats;
  final List<Passenger> passengers;
  final double totalAmount;
  final bool isLoading;
  final String? error;

  BookingFlowState({
    this.selectedBus,
    this.selectedSeats = const [],
    this.passengers = const [],
    this.totalAmount = 0.0,
    this.isLoading = false,
    this.error,
  });

  BookingFlowState copyWith({
    BusRecord? selectedBus,
    List<String>? selectedSeats,
    List<Passenger>? passengers,
    double? totalAmount,
    bool? isLoading,
    String? error,
  }) {
    return BookingFlowState(
      selectedBus: selectedBus ?? this.selectedBus,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      passengers: passengers ?? this.passengers,
      totalAmount: totalAmount ?? this.totalAmount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
