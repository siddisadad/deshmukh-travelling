import '../entities/bus_search_entity.dart';
import '../repositories/bus_search_repository.dart';

class SearchBusesUseCase {
  final BusSearchRepository repository;

  SearchBusesUseCase(this.repository);

  Future<List<BusSearchEntity>> execute({
    required String from,
    required String to,
    DateTime? date,
  }) {
    return repository.searchBuses(from: from, to: to, date: date);
  }
}
