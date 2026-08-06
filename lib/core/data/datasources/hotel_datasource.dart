import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/hotel_record.dart';
import '../../../backend/schema/room_record.dart';

abstract class HotelDataSource {
  Future<List<HotelRecord>> getHotels(String city);
  Future<List<RoomRecord>> getRooms(String hotelId);
}

class FirestoreHotelDataSource implements HotelDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreHotelDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<HotelRecord>> getHotels(String city) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(seconds: 1));
      return [
        HotelRecord.fromMap({
          'name': 'Grand Hyatt Mumbai',
          'location': 'Santacruz East, Mumbai',
          'description': 'Luxury hotel with world-class amenities.',
          'rating': 4.8,
          'reviewsCount': 1240,
          'images': ['https://images.unsplash.com/photo-1566073771259-6a8506099945'],
          'amenities': ['WiFi', 'Pool', 'Gym', 'Spa'],
          'startingPrice': 8500.0,
          'city': 'Mumbai',
        }, 'h1'),
      ];
    }

    try {
      final snapshot =
          await _db.collection('hotels').where('city', isEqualTo: city).get();

      return snapshot.docs.map((doc) => HotelRecord.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching hotels', originalError: e);
    }
  }

  @override
  Future<List<RoomRecord>> getRooms(String hotelId) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        RoomRecord.fromMap({
          'hotelId': hotelId,
          'type': 'Deluxe Room',
          'price': 8500.0,
          'capacity': 2,
          'amenities': ['King Bed', 'City View', 'WiFi'],
          'isAvailable': true,
          'image': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304',
        }, 'r1'),
      ];
    }

    try {
      final snapshot = await _db
          .collection('rooms')
          .where('hotelId', isEqualTo: hotelId)
          .where('isAvailable', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => RoomRecord.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching rooms', originalError: e);
    }
  }
}
