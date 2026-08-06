import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../../../core/data/datasources/booking_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource _dataSource;

  BookingRepositoryImpl(this._dataSource);

  @override
  Future<List<BookingEntity>> getUserBookings(String userId) async {
    final records = await _dataSource.fetchUserBookings(userId);
    return records.map((r) => BookingEntity(
      id: r.id ?? '',
      userId: r.userId,
      serviceName: r.busName,
      serviceType: r.busType,
      from: r.departureCity,
      to: r.arrivalCity,
      departureTime: r.depTime,
      arrivalTime: r.arrTime,
      amount: r.totalAmount,
      status: r.status,
      date: r.timestamp,
    )).toList();
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await _dataSource.cancelBooking(bookingId);
  }
}
