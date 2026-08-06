import 'dart:async';
import '../../../../backend/firebase/firestore_service.dart';
import '../../../../backend/schema/bus_record.dart';
import '../../../../core/data/result.dart';
import '../../domain/entities/bus_location.dart';
import '../../domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements ITrackingRepository {
  final FirestoreService _firestoreService;

  TrackingRepositoryImpl(this._firestoreService);

  @override
  Stream<Result<BusLocation>> getBusLocationStream(String busId) {
    // For simplicity in this migration, we'll use mock bus data if we can't find the bus.
    // In a real app, you might fetch it first or pass it in.
    final mockBus = BusRecord(
      id: busId,
      name: 'Deshmukh Luxury',
      type: 'Volvo Multi-Axle AC',
      price: 850.0,
      departureCity: 'Mumbai',
      arrivalCity: 'Pune',
      depTime: '08:30 PM',
      arrTime: '06:00 AM',
      rating: '4.8',
      seatsAvailable: '12',
    );

    return _firestoreService.getBusLocationStream(busId).map((coords) {
      try {
        return Result.success(BusLocation(
          bus: mockBus,
          latitude: coords['lat'] ?? 0.0,
          longitude: coords['lng'] ?? 0.0,
          driverName: 'Suresh Patil',
          driverPhone: '+919876543210',
          busNumber: 'MH-12-AS-1234',
        ));
      } catch (e) {
        return Result.error(AppException(e.toString()));
      }
    });
  }

  @override
  Future<Result<void>> sendSosAlert(String busId, String userId) async {
    try {
      // Mock SOS alert logic
      await Future.delayed(const Duration(seconds: 1));
      return Result.success(null);
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }
}
