import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/taxi_record.dart';

abstract class TaxiDataSource {
  Future<List<TaxiRecord>> fetchTaxis();
}

class FirestoreTaxiDataSource implements TaxiDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreTaxiDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<TaxiRecord>> fetchTaxis() async {
    if (!useRealFirestore) return [];
    try {
      final snapshot = await _db.collection('taxis').get();
      return snapshot.docs.map((doc) => TaxiRecord.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching taxis', originalError: e);
    }
  }
}
