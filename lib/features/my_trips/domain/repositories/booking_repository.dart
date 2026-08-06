import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<List<BookingEntity>> getUserBookings(String userId);
  Future<void> cancelBooking(String bookingId);
}
