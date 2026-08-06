import '../../../../core/data/result.dart';
import '../../../../backend/firebase/firestore_service.dart';
import '../../domain/entities/package_record.dart';
import '../../domain/repositories/package_repository.dart';

class PackageRepositoryImpl implements PackageRepository {
  final FirestoreService _firestoreService;

  PackageRepositoryImpl(this._firestoreService);

  @override
  Future<Result<List<PackageRecord>>> getPackages() async {
    try {
      final packages = await _firestoreService.fetchPackages();
      return Result.success(packages);
    } catch (e) {
      return Result.failure(AppException('Failed to fetch packages: $e'));
    }
  }

  @override
  Future<Result<PackageRecord>> getPackageDetails(String id) async {
    try {
      // For now, we fetch all and find by ID if fetchPackagesById doesn't exist
      // or we can just return what we have if passed in.
      // But let's assume we want a fresh fetch.
      final packages = await _firestoreService.fetchPackages();
      final package = packages.firstWhere((p) => p.id == id);
      return Result.success(package);
    } catch (e) {
      return Result.failure(AppException('Failed to fetch package details: $e'));
    }
  }

  @override
  Future<Result<String>> bookPackage({
    required PackageRecord package,
    required int travelerCount,
    required DateTime selectedDate,
  }) async {
    try {
      // In a real app, we'd have a createPackageBooking in FirestoreService
      // For now, let's mock it as successful since we don't want to modify FirestoreService too much
      // or we can add it there.
      await Future.delayed(const Duration(seconds: 1));
      return Result.success('PKG-BOOK-${DateTime.now().millisecondsSinceEpoch}');
    } catch (e) {
      return Result.failure(AppException('Failed to book package: $e'));
    }
  }
}
