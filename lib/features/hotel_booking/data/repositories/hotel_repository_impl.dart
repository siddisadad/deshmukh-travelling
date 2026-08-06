import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../../../../backend/schema/hotel_record.dart';
import '../../../../backend/schema/room_record.dart';
import '../../../../backend/schema/hotel_booking_record.dart';
import '../../../../core/data/result.dart';

class HotelRepositoryImpl implements HotelRepository {
  final FirebaseFirestore _firestore;

  HotelRepositoryImpl(this._firestore);

  @override
  Future<Result<List<HotelRecord>>> searchHotels(String destination) async {
    try {
      final snapshot = await _firestore
          .collection('hotels')
          .where('city', isEqualTo: destination)
          .get();

      final hotels = snapshot.docs.map((doc) => HotelRecord.fromFirestore(doc)).toList();
      return Result.success(hotels);
    } catch (e) {
      return Result.failure(ServerException('Failed to search hotels: $e'));
    }
  }

  @override
  Future<Result<List<RoomRecord>>> getRoomsForHotel(String hotelId) async {
    try {
      final snapshot = await _firestore
          .collection('rooms')
          .where('hotelId', isEqualTo: hotelId)
          .get();

      final rooms = snapshot.docs.map((doc) => RoomRecord.fromFirestore(doc)).toList();
      return Result.success(rooms);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch rooms: $e'));
    }
  }

  @override
  Future<Result<void>> createBooking(HotelBookingRecord booking) async {
    try {
      await _firestore.collection('hotel_bookings').add(booking.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to create booking: $e'));
    }
  }
}
