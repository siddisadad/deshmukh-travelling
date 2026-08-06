import '../../../../core/data/result.dart';
import '../entities/package_record.dart';

abstract class PackageRepository {
  Future<Result<List<PackageRecord>>> getPackages();
  Future<Result<PackageRecord>> getPackageDetails(String id);
  Future<Result<String>> bookPackage({
    required PackageRecord package,
    required int travelerCount,
    required DateTime selectedDate,
  });
}
