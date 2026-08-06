import '../entities/bus_search_entity.dart';

abstract class BusSearchRepository {
  Future<List<BusSearchEntity>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  });
}
