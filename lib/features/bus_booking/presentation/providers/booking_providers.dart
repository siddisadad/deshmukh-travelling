import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase/firestore_service.dart';
import '../../../../backend/schema/bus_record.dart';
import '../../../../backend/schema/booking_record.dart';
import '../../domain/repositories/bus_repository.dart';
import '../../data/repositories/bus_repository_impl.dart';
import '../../domain/entities/booking_flow_state.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());

final busRepositoryProvider = Provider<BusRepository>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return BusRepositoryImpl(firestoreService);
});

final busSearchProvider = FutureProvider.family<List<BusRecord>, ({String from, String to})>((ref, params) async {
  final repository = ref.watch(busRepositoryProvider);
  final result = await repository.searchBuses(from: params.from, to: params.to);

  return result.fold(
    (data) => data,
    (exception) => throw exception,
  );
});

final bookedSeatsProvider = FutureProvider.family<List<String>, String>((ref, busId) async {
  final repository = ref.watch(busRepositoryProvider);
  final result = await repository.getBookedSeats(busId);

  return result.fold(
    (data) => data,
    (exception) => throw exception,
  );
});

class BookingFlowNotifier extends StateNotifier<BookingFlowState> {
  BookingFlowNotifier() : super(BookingFlowState());

  void selectBus(BusRecord bus) {
    state = state.copyWith(selectedBus: bus, selectedSeats: [], passengers: [], totalAmount: 0.0);
  }

  void toggleSeat(String seatNumber) {
    final seats = List<String>.from(state.selectedSeats);
    if (seats.contains(seatNumber)) {
      seats.remove(seatNumber);
    } else {
      seats.add(seatNumber);
    }

    final price = state.selectedBus?.price ?? 0.0;
    state = state.copyWith(
      selectedSeats: seats,
      totalAmount: seats.length * price,
    );
  }

  void updatePassengers(List<Passenger> passengers) {
    state = state.copyWith(passengers: passengers);
  }

  void reset() {
    state = BookingFlowState();
  }
}

final bookingFlowProvider = StateNotifierProvider<BookingFlowNotifier, BookingFlowState>((ref) {
  return BookingFlowNotifier();
});
