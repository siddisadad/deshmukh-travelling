import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/taxi_record.dart';
import '/backend/schema/rental_record.dart';
import '/core/data/result.dart';
import '../domain/taxi_rental_repository.dart';

class TaxiRentalRepositoryImpl implements TaxiRentalRepository {
  final FirebaseFirestore _firestore;

  TaxiRentalRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<List<TaxiRecord>>> getAvailableTaxis() async {
    try {
      final snapshot = await _firestore.collection('taxis').get();
      final taxis = snapshot.docs
          .map((doc) => TaxiRecord.fromFirestore(doc))
          .toList();
      return Result.success(taxis);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch taxis', originalError: e));
    }
  }

  @override
  Future<Result<List<RentalRecord>>> getAvailableRentals() async {
    try {
      final snapshot = await _firestore.collection('rentals').get();
      final rentals = snapshot.docs
          .map((doc) => RentalRecord.fromFirestore(doc))
          .toList();
      return Result.success(rentals);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch rentals', originalError: e));
    }
  }

  @override
  Future<Result<void>> bookTaxi(TaxiRecord taxi, String pickup, String drop) async {
    try {
      await _firestore.collection('taxi_bookings').add({
        'taxiId': taxi.id,
        'vehicleName': taxi.vehicleName,
        'pickup': pickup,
        'drop': drop,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'booked',
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to book taxi', originalError: e));
    }
  }

  @override
  Future<Result<void>> bookRental(RentalRecord rental) async {
    try {
      await _firestore.collection('rental_bookings').add({
        'rentalId': rental.id,
        'vehicleName': rental.vehicleName,
        'pricePerDay': rental.pricePerDay,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'booked',
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to book rental', originalError: e));
    }
  }
}
