import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/booking_record.dart';
import '../../../backend/schema/hotel_booking_record.dart';

abstract class BookingDataSource {
  Future<List<BookingRecord>> fetchUserBookings(String userId);
  Future<String?> createBooking(BookingRecord booking);
  Future<String?> createHotelBooking(HotelBookingRecord booking);
  Future<void> cancelBooking(String bookingId);
}

class FirestoreBookingDataSource implements BookingDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreBookingDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<BookingRecord>> fetchUserBookings(String userId) async {
    if (!useRealFirestore) return [];
    try {
      final snapshot = await _db
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => BookingRecord.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching bookings',
          originalError: e);
    }
  }

  @override
  Future<String?> createBooking(BookingRecord booking) async {
    if (!useRealFirestore) return 'mock_id';
    try {
      final docRef = await _db.collection('bookings').add(booking.toMap());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error creating booking', originalError: e);
    }
  }

  @override
  Future<String?> createHotelBooking(HotelBookingRecord booking) async {
    if (!useRealFirestore) return 'mock_id';
    try {
      final docRef =
          await _db.collection('hotel_bookings').add(booking.toMap());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error creating hotel booking',
          originalError: e);
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    if (!useRealFirestore) return;
    try {
      await _db
          .collection('bookings')
          .doc(bookingId)
          .update({'status': 'cancelled'});
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error cancelling booking',
          originalError: e);
    }
  }
}
