import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase/firestore_service.dart';
import '../../data/repositories/routes_repository_impl.dart';
import '../../data/repositories/tracking_repository_impl.dart';
import '../../domain/entities/bus_location.dart';
import '../../domain/entities/popular_route.dart';
import '../../domain/repositories/routes_repository.dart';
import '../../domain/repositories/tracking_repository.dart';

final trackingRepositoryProvider = Provider<ITrackingRepository>((ref) {
  return TrackingRepositoryImpl(FirestoreService());
});

final routesRepositoryProvider = Provider<IRoutesRepository>((ref) {
  return RoutesRepositoryImpl();
});

final busTrackingProvider = StreamProvider.family<BusLocation, String>((ref, busId) {
  final repository = ref.watch(trackingRepositoryProvider);
  return repository.getBusLocationStream(busId).map((result) {
    return result.fold(
      (data) => data,
      (error) => throw Exception(error.message),
    );
  });
});

final popularRoutesProvider = FutureProvider<List<PopularRoute>>((ref) async {
  final repository = ref.watch(routesRepositoryProvider);
  final result = await repository.getPopularRoutes();
  return result.fold(
    (data) => data,
    (error) => throw Exception(error.message),
  );
});
