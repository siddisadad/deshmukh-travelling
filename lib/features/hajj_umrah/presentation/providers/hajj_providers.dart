import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/hajj_package.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/itinerary.dart';
import '../../domain/repositories/hajj_repository.dart';
import '../../data/repositories/hajj_repository_impl.dart';

final hajjRepositoryProvider = Provider<HajjRepository>((ref) {
  return HajjRepositoryImpl();
});

final hajjPackagesProvider = FutureProvider.family<List<HajjPackage>, PackageType?>((ref, type) async {
  final repository = ref.watch(hajjRepositoryProvider);
  return repository.getPackages(type: type);
});

final hajjPackageDetailsProvider = FutureProvider.family<HajjPackage?, String>((ref, id) async {
  final repository = ref.watch(hajjRepositoryProvider);
  return repository.getPackageDetails(id);
});

final hajjItineraryProvider = FutureProvider.family<List<Itinerary>, String>((ref, packageId) async {
  final repository = ref.watch(hajjRepositoryProvider);
  return repository.getItinerary(packageId);
});

final userHajjBookingsProvider = FutureProvider.family<List<Booking>, String>((ref, userId) async {
  final repository = ref.watch(hajjRepositoryProvider);
  return repository.getUserBookings(userId);
});

final selectedPackageProvider = StateProvider<HajjPackage?>((ref) => null);
