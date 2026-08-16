import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SeatsRecord {
  SeatsRecord._(this.reference, this.data);

  final DocumentReference? reference;
  final Map<String, dynamic> data;

  String get number => data['number'] as String? ?? '';
  String get status =>
      data['status'] as String? ?? ''; // available, booked, selected

  static CollectionReference collection(DocumentReference busRef) =>
      busRef.collection('seats');

  /// Demo seat map used when the bus has no seats subcollection yet.
  static List<SeatsRecord> demoSeats({int count = 16}) {
    return List<SeatsRecord>.generate(count, (index) {
      final number = '${index + 1}';
      final booked = index == 2 || index == 6 || index == 11 || index == 14;
      return SeatsRecord._(
        null,
        {
          'number': number,
          'status': booked ? 'booked' : 'available',
        },
      );
    });
  }

  static Stream<List<SeatsRecord>> getStream(DocumentReference? busRef) async* {
    yield demoSeats();
    if (busRef == null || Firebase.apps.isEmpty) {
      return;
    }

    try {
      await for (final snapshot in collection(busRef).snapshots()) {
        final seats = snapshot.docs
            .map(
              (doc) => SeatsRecord._(
                doc.reference,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();
        yield seats.isEmpty ? demoSeats() : seats;
      }
    } catch (_) {
      yield demoSeats();
    }
  }

  static SeatsRecord fromSnapshot(DocumentSnapshot snapshot) => SeatsRecord._(
        snapshot.reference,
        snapshot.data() as Map<String, dynamic>,
      );
}
