import '../entities/hotel_entity.dart';

abstract class HotelRepository {
  Future<List<HotelEntity>> searchHotels(String city);
  Future<List<RoomEntity>> getRooms(String hotelId);
}
