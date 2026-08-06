import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../features/packages/domain/entities/package_record.dart';

abstract class PackageDataSource {
  Future<List<PackageRecord>> fetchPackages();
}

class FirestorePackageDataSource implements PackageDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestorePackageDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<PackageRecord>> fetchPackages() async {
    if (!useRealFirestore) return [];
    try {
      final snapshot = await _db.collection('packages').get();
      return snapshot.docs
          .map((doc) => PackageRecord.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching packages',
          originalError: e);
    }
  }
}
