import '../../../../backend/schema/hotel_record.dart';
import '../../../../backend/schema/room_record.dart';
import '../../../../backend/schema/hotel_booking_record.dart';
import '../../../../core/data/result.dart';

abstract class HotelRepository {
  Future<Result<List<HotelRecord>>> searchHotels(String destination);
  Future<Result<List<RoomRecord>>> getRoomsForHotel(String hotelId);
  Future<Result<void>> createBooking(HotelBookingRecord booking);
}
