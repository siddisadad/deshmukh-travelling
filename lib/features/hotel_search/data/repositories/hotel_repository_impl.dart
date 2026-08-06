import '../../domain/entities/hotel_entity.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../../../../core/data/datasources/hotel_datasource.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelDataSource _dataSource;

  HotelRepositoryImpl(this._dataSource);

  @override
  Future<List<HotelEntity>> searchHotels(String city) async {
    final records = await _dataSource.getHotels(city);
    return records.map((r) => HotelEntity(
      id: r.id,
      name: r.name,
      location: r.location,
      description: r.description,
      rating: r.rating,
      reviewsCount: r.reviewsCount,
      images: r.images,
      amenities: r.amenities,
      startingPrice: r.startingPrice,
      city: r.city,
    )).toList();
  }

  @override
  Future<List<RoomEntity>> getRooms(String hotelId) async {
    final records = await _dataSource.getRooms(hotelId);
    return records.map((r) => RoomEntity(
      id: r.id,
      hotelId: r.hotelId,
      type: r.type,
      price: r.price,
      capacity: r.capacity,
      amenities: r.amenities,
      isAvailable: r.isAvailable,
      image: r.image,
    )).toList();
  }
}
