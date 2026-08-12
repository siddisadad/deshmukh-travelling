import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusesRecord {
  BusesRecord._(this.reference, this.data);

  final DocumentReference reference;
  final Map<String, dynamic> data;

  String get operator => data['operator'] as String? ?? '';
  String get type => data['type'] as String? ?? '';
  String get depTime => data['depTime'] as String? ?? '';
  String get arrTime => data['arrTime'] as String? ?? '';
  String get duration => data['duration'] as String? ?? '';
  double get price => castToDouble(data['price']);
  double get rating => castToDouble(data['rating']);
  int get seatsAvailable => data['seats_available'] as int? ?? 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('buses');

  static Stream<List<BusesRecord>> getStream({String filter = 'All'}) {
    Query query = collection;
    if (filter != 'All') {
      // Assuming 'type' field contains the filter keywords (e.g. 'AC', 'Sleeper')
      query = query.where('type', arrayContains: filter);
    }
    return query.snapshots().map((s) => s.docs
        .map((d) => BusesRecord._(d.reference, d.data() as Map<String, dynamic>))
        .toList());
  }

  static BusesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BusesRecord._(snapshot.reference, snapshot.data() as Map<String, dynamic>);
}
