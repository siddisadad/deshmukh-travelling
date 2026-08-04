import '../firebase/firestore_service.dart';
import '../schema/bus_record.dart';

abstract class BusRepository {
  Future<List<BusRecord>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  });
}

class FirestoreBusRepository implements BusRepository {
  final FirestoreService _service;

  FirestoreBusRepository({FirestoreService? service})
      : _service = service ?? FirestoreService();

  @override
  Future<List<BusRecord>> searchBuses({
    required String from,
    required String to,
    DateTime? date,
  }) {
    // Currently redirects to our existing service,
    // but allows for future injection of caching or local data.
    return _service.fetchBuses(from, to);
  }
}
