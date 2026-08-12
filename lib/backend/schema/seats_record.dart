import 'package:cloud_firestore/cloud_firestore.dart';

class SeatsRecord {
  SeatsRecord._(this.reference, this.data);

  final DocumentReference reference;
  final Map<String, dynamic> data;

  String get number => data['number'] as String? ?? '';
  String get status => data['status'] as String? ?? ''; // available, booked, selected

  static CollectionReference collection(DocumentReference busRef) =>
      busRef.collection('seats');

  static Stream<List<SeatsRecord>> getStream(DocumentReference busRef) =>
      collection(busRef).snapshots().map((s) => s.docs
          .map((d) => SeatsRecord._(d.reference, d.data() as Map<String, dynamic>))
          .toList());

  static SeatsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SeatsRecord._(snapshot.reference, snapshot.data() as Map<String, dynamic>);
}
