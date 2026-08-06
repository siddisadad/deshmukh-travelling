import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/taxi_rental_repository.dart';
import '../../data/taxi_rental_repository_impl.dart';
import '/backend/schema/taxi_record.dart';
import '/backend/schema/rental_record.dart';
import '/core/data/result.dart';

final taxiRentalRepositoryProvider = Provider<TaxiRentalRepository>((ref) {
  return TaxiRentalRepositoryImpl();
});

final availableTaxisProvider = FutureProvider<Result<List<TaxiRecord>>>((ref) async {
  final repository = ref.watch(taxiRentalRepositoryProvider);
  return repository.getAvailableTaxis();
});

final availableRentalsProvider = FutureProvider<Result<List<RentalRecord>>>((ref) async {
  final repository = ref.watch(taxiRentalRepositoryProvider);
  return repository.getAvailableRentals();
});

final selectedTaxiProvider = StateProvider<TaxiRecord?>((ref) => null);
final pickupLocationProvider = StateProvider<String>((ref) => 'Your current location');
final dropLocationProvider = StateProvider<String>((ref) => '');
