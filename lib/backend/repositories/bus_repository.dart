import '../../core/data/datasources/bus_datasource.dart';
import '../schema/bus_record.dart';

abstract class BusRepository {
  Future<List<BusRecord>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  });
}

class FirestoreBusRepository implements BusRepository {
  final BusDataSource _dataSource;

  FirestoreBusRepository({BusDataSource? dataSource})
      : _dataSource = dataSource ?? FirestoreBusDataSource();

  @override
  Future<List<BusRecord>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  }) {
    return _dataSource.getBuses(from, to);
  }
}
