import '../entities/hotel_entity.dart';
import '../repositories/hotel_repository.dart';

class SearchHotelsUseCase {
  final HotelRepository repository;

  SearchHotelsUseCase(this.repository);

  Future<List<HotelEntity>> execute(String city) {
    return repository.searchHotels(city);
  }
}
