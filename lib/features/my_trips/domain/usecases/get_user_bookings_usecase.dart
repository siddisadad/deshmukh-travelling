import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class GetUserBookingsUseCase {
  final BookingRepository repository;

  GetUserBookingsUseCase(this.repository);

  Future<List<BookingEntity>> execute(String userId) {
    return repository.getUserBookings(userId);
  }
}
