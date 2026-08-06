import '../../../../core/data/result.dart';
import '../entities/bus_location.dart';

abstract class ITrackingRepository {
  Stream<Result<BusLocation>> getBusLocationStream(String busId);
  Future<Result<void>> sendSosAlert(String busId, String userId);
}
