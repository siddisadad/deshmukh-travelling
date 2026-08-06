import '../../../../backend/firebase/firestore_service.dart';
import '../../../../backend/schema/bus_record.dart';
import '../../../../backend/schema/booking_record.dart';
import '../../../../core/data/result.dart';
import '../../domain/repositories/bus_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusRepositoryImpl implements BusRepository {
  final FirestoreService _firestoreService;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  BusRepositoryImpl(this._firestoreService);

  @override
  Future<Result<List<BusRecord>>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  }) async {
    try {
      final buses = await _firestoreService.fetchBuses(from, to);
      return Result.success(buses);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch buses: $e'));
    }
  }

  @override
  Future<Result<BookingRecord>> createBooking(BookingRecord booking) async {
    try {
      final id = await _firestoreService.createBooking(booking);
      if (id != null) {
        // Return a new BookingRecord with the ID
        final newBooking = BookingRecord(
          id: id,
          userId: booking.userId,
          busId: booking.busId,
          busName: booking.busName,
          busType: booking.busType,
          departureCity: booking.departureCity,
          arrivalCity: booking.arrivalCity,
          depTime: booking.depTime,
          arrTime: booking.arrTime,
          seatNumbers: booking.seatNumbers,
          passengers: booking.passengers,
          totalAmount: booking.totalAmount,
          status: booking.status,
          timestamp: booking.timestamp,
        );
        return Result.success(newBooking);
      } else {
        return Result.failure(ServerException('Failed to create booking'));
      }
    } catch (e) {
      return Result.failure(ServerException('Error creating booking: $e'));
    }
  }

  @override
  Future<Result<List<String>>> getBookedSeats(String busId) async {
    try {
      if (!FirestoreService.useRealFirestore) {
        return Result.success(['1A', '2B', '5C']);
      }

      final snapshot = await _db
          .collection('bookings')
          .where('busId', isEqualTo: busId)
          .where('status', isEqualTo: 'Confirmed')
          .get();

      final bookedSeats = <String>[];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final seats = List<String>.from(data['seatNumbers'] ?? []);
        bookedSeats.addAll(seats);
      }
      return Result.success(bookedSeats);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch booked seats: $e'));
    }
  }
}
