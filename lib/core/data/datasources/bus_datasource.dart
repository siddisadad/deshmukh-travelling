import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/bus_record.dart';

abstract class BusDataSource {
  Future<List<BusRecord>> getBuses(String from, String to);
  Stream<Map<String, double>> getBusLocationStream(String busId);
}

class FirestoreBusDataSource implements BusDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreBusDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<BusRecord>> getBuses(String from, String to) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(seconds: 1));
      return [
        BusRecord.fromMap({
          'name': 'Deshmukh Premium AC',
          'type': 'Volvo Multi-Axle AC',
          'price': 850.0,
          'departureCity': from,
          'arrivalCity': to,
          'depTime': '08:30 AM',
          'arrTime': '12:45 PM',
          'rating': '4.8',
          'seatsAvailable': '12'
        }, 'bus1'),
        BusRecord.fromMap({
          'name': 'Shivneri Express',
          'type': 'Scania Luxury AC',
          'price': 720.0,
          'departureCity': from,
          'arrivalCity': to,
          'depTime': '10:15 AM',
          'arrTime': '02:00 PM',
          'rating': '4.5',
          'seatsAvailable': '4'
        }, 'bus2'),
      ];
    }

    try {
      final snapshot = await _db.collection('buses')
          .where('departureCity', isEqualTo: from)
          .where('arrivalCity', isEqualTo: to)
          .get();

      return snapshot.docs.map((doc) => BusRecord.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error', code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching buses', originalError: e);
    }
  }

  @override
  Stream<Map<String, double>> getBusLocationStream(String busId) {
    if (!useRealFirestore) {
      return Stream.periodic(const Duration(seconds: 3), (i) {
        return {
          'lat': 19.1000 + (i * 0.001),
          'lng': 72.8800 + (i * 0.001),
        };
      });
    }

    return _db.collection('bus_locations').doc(busId).snapshots().map((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        return {
          'lat': (data['lat'] ?? 0.0).toDouble(),
          'lng': (data['lng'] ?? 0.0).toDouble(),
        };
      }
      return {'lat': 0.0, 'lng': 0.0};
    });
  }
}
