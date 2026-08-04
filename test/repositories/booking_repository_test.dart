import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/backend/repositories/booking_repository.dart';
import 'package:deshmukh_travelling/backend/schema/booking_record.dart';
import 'package:deshmukh_travelling/backend/firebase/firestore_service.dart';

class MockFirestoreService extends FirestoreService {
  @override
  Future<List<BookingRecord>> fetchUserBookings(String userId) async {
    return [
      BookingRecord(
        id: '1',
        userId: userId,
        busId: 'bus1',
        busName: 'Mock Bus',
        busType: 'AC',
        departureCity: 'Mumbai',
        arrivalCity: 'Pune',
        depTime: '10:00 AM',
        arrTime: '2:00 PM',
        seatNumbers: ['1', '2'],
        passengers: [],
        totalAmount: 2000,
        status: 'confirmed',
        timestamp: DateTime.now(),
      )
    ];
  }
}

void main() {
  group('FirestoreBookingRepository Tests', () {
    test('getBookingsForUser returns a list of BookingRecord', () async {
      final repository = FirestoreBookingRepository(service: MockFirestoreService());
      final bookings = await repository.getBookingsForUser('test_user');

      expect(bookings, isA<List<BookingRecord>>());
      expect(bookings.length, 1);
    });
  });
}
