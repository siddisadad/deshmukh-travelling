import '../firebase/firestore_service.dart';
import '../schema/booking_record.dart';

abstract class BookingRepository {
  Future<String?> createBooking(BookingRecord booking);
  Future<List<BookingRecord>> getBookingsForUser(String userId);
}

class FirestoreBookingRepository implements BookingRepository {
  final FirestoreService _service;

  FirestoreBookingRepository({FirestoreService? service})
      : _service = service ?? FirestoreService();

  @override
  Future<String?> createBooking(BookingRecord booking) {
    return _service.createBooking(booking);
  }

  @override
  Future<List<BookingRecord>> getBookingsForUser(String userId) {
    return _service.fetchUserBookings(userId);
  }
}
