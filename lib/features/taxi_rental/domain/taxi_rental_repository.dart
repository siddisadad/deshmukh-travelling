import '/backend/schema/taxi_record.dart';
import '/backend/schema/rental_record.dart';
import '/core/data/result.dart';

abstract class TaxiRentalRepository {
  Future<Result<List<TaxiRecord>>> getAvailableTaxis();
  Future<Result<List<RentalRecord>>> getAvailableRentals();
  Future<Result<void>> bookTaxi(TaxiRecord taxi, String pickup, String drop);
  Future<Result<void>> bookRental(RentalRecord rental);
}
