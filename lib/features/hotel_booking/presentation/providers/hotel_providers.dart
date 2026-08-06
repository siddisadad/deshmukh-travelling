import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../../data/repositories/hotel_repository_impl.dart';
import '../../../../backend/schema/hotel_record.dart';
import '../../../../backend/schema/room_record.dart';
import '../../../../backend/schema/hotel_booking_record.dart';
import '../../../../core/data/result.dart';

final hotelRepositoryProvider = Provider<HotelRepository>((ref) {
  return HotelRepositoryImpl(FirebaseFirestore.instance);
});

final hotelSearchProvider = FutureProvider.family<Result<List<HotelRecord>>, String>((ref, destination) async {
  final repository = ref.watch(hotelRepositoryProvider);
  return repository.searchHotels(destination);
});

final hotelRoomsProvider = FutureProvider.family<Result<List<RoomRecord>>, String>((ref, hotelId) async {
  final repository = ref.watch(hotelRepositoryProvider);
  return repository.getRoomsForHotel(hotelId);
});

class HotelBookingState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  HotelBookingState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  HotelBookingState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return HotelBookingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class HotelBookingNotifier extends StateNotifier<HotelBookingState> {
  final HotelRepository _repository;

  HotelBookingNotifier(this._repository) : super(HotelBookingState());

  Future<void> createBooking(HotelBookingRecord booking) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createBooking(booking);
    result.fold(
      (data) => state = state.copyWith(isLoading: false, isSuccess: true),
      (exception) => state = state.copyWith(isLoading: false, error: exception.message),
    );
  }
}

final hotelBookingNotifierProvider = StateNotifierProvider<HotelBookingNotifier, HotelBookingState>((ref) {
  final repository = ref.watch(hotelRepositoryProvider);
  return HotelBookingNotifier(repository);
});
