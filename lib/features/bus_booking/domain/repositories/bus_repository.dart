import '../../../../core/data/result.dart';
import '../../../../backend/schema/bus_record.dart';
import '../../../../backend/schema/booking_record.dart';

abstract class BusRepository {
  Future<Result<List<BusRecord>>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  });

  Future<Result<BookingRecord>> createBooking(BookingRecord booking);

  Future<Result<List<String>>> getBookedSeats(String busId);
}
