import '../../core/data/datasources/booking_datasource.dart';
import '../schema/booking_record.dart';

abstract class BookingRepository {
  Future<String?> createBooking(BookingRecord booking);
  Future<List<BookingRecord>> getBookingsForUser(String userId);
}

class FirestoreBookingRepository implements BookingRepository {
  final BookingDataSource _dataSource;

  FirestoreBookingRepository({BookingDataSource? dataSource})
      : _dataSource = dataSource ?? FirestoreBookingDataSource();

  @override
  Future<String?> createBooking(BookingRecord booking) {
    return _dataSource.createBooking(booking);
  }

  @override
  Future<List<BookingRecord>> getBookingsForUser(String userId) {
    return _dataSource.fetchUserBookings(userId);
  }
}
