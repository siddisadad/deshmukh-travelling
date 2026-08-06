import '../../domain/entities/bus_search_entity.dart';
import '../../domain/repositories/bus_search_repository.dart';
import '../../../../core/data/datasources/bus_datasource.dart';

class BusSearchRepositoryImpl implements BusSearchRepository {
  final BusDataSource _dataSource;

  BusSearchRepositoryImpl(this._dataSource);

  @override
  Future<List<BusSearchEntity>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  }) async {
    final busRecords = await _dataSource.getBuses(from, to);
    return busRecords.map((record) => BusSearchEntity(
      id: record.id,
      name: record.name,
      type: record.type,
      price: record.price,
      departureCity: record.departureCity,
      arrivalCity: record.arrivalCity,
      departureTime: record.depTime,
      arrivalTime: record.arrTime,
      rating: record.rating,
      seatsAvailable: int.tryParse(record.seatsAvailable) ?? 0,
    )).toList();
  }
}
