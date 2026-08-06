import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/features/hotel_search/data/repositories/hotel_repository_impl.dart';
import 'package:deshmukh_travelling/core/data/datasources/hotel_datasource.dart';
import 'package:deshmukh_travelling/backend/schema/hotel_record.dart';
import 'package:deshmukh_travelling/backend/schema/room_record.dart';

class MockHotelDataSource implements HotelDataSource {
  @override
  Future<List<HotelRecord>> getHotels(String city) async {
    return [
      HotelRecord(
        id: 'h1',
        name: 'Mock Hotel',
        location: 'Near Center',
        description: 'Desc',
        rating: 4.5,
        reviewsCount: 10,
        images: ['img'],
        amenities: ['wifi'],
        startingPrice: 2000,
        city: city,
      ),
    ];
  }

  @override
  Future<List<RoomRecord>> getRooms(String hotelId) async {
    return [
      RoomRecord(
        id: 'r1',
        hotelId: hotelId,
        type: 'Deluxe',
        price: 2000,
        capacity: 2,
        amenities: ['AC'],
        isAvailable: true,
        image: 'img',
      ),
    ];
  }
}

void main() {
  group('HotelRepositoryImpl Tests', () {
    test('searchHotels returns list of HotelEntity', () async {
      final repository = HotelRepositoryImpl(MockHotelDataSource());
      final result = await repository.searchHotels('Mumbai');

      expect(result, isNotEmpty);
      expect(result.first.name, 'Mock Hotel');
      expect(result.first.city, 'Mumbai');
    });

    test('getRooms returns list of RoomEntity', () async {
      final repository = HotelRepositoryImpl(MockHotelDataSource());
      final result = await repository.getRooms('h1');

      expect(result, isNotEmpty);
      expect(result.first.type, 'Deluxe');
    });
  });
}
