import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusesRecord {
  BusesRecord._(this.reference, this.data);

  final DocumentReference? reference;
  final Map<String, dynamic> data;

  String get operator => data['operator'] as String? ?? '';
  String get type => data['type'] as String? ?? '';
  String get depTime => data['depTime'] as String? ?? '';
  String get arrTime => data['arrTime'] as String? ?? '';
  String get duration => data['duration'] as String? ?? '';
  double get price => castToType<double>(data['price']) ?? 0.0;
  double get rating => castToType<double>(data['rating']) ?? 0.0;
  int get seatsAvailable => data['seats_available'] as int? ?? 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('buses');

  /// Demo buses used when Firestore is empty or unavailable so the booking UI
  /// remains usable during local/Cloud Agent development.
  static List<BusesRecord> demoBuses({String filter = 'All'}) {
    final samples = <Map<String, dynamic>>[
      {
        'operator': 'Deshmukh Travels',
        'type': 'AC Sleeper',
        'depTime': '22:30',
        'arrTime': '06:00',
        'duration': '7h 30m',
        'price': 899.0,
        'rating': 4.6,
        'seats_available': 12,
        'id': 'demo-ac-sleeper',
      },
      {
        'operator': 'Orange Tours',
        'type': 'Non-AC Seater',
        'depTime': '07:15',
        'arrTime': '12:45',
        'duration': '5h 30m',
        'price': 499.0,
        'rating': 4.1,
        'seats_available': 24,
        'id': 'demo-non-ac-seater',
      },
      {
        'operator': 'Royal Luxury',
        'type': 'Luxury AC',
        'depTime': '21:00',
        'arrTime': '04:30',
        'duration': '7h 30m',
        'price': 1299.0,
        'rating': 4.8,
        'seats_available': 8,
        'id': 'demo-luxury-ac',
      },
      {
        'operator': 'City Express',
        'type': 'AC Seater',
        'depTime': '14:00',
        'arrTime': '19:20',
        'duration': '5h 20m',
        'price': 650.0,
        'rating': 4.3,
        'seats_available': 18,
        'id': 'demo-ac-seater',
      },
    ];

    return samples
        .map(
          (data) {
            DocumentReference? reference;
            try {
              if (Firebase.apps.isNotEmpty) {
                reference = collection.doc(data['id'] as String);
              }
            } catch (_) {
              reference = null;
            }
            return BusesRecord._(reference, data);
          },
        )
        .where((bus) => _matchesFilter(bus.type, filter))
        .toList();
  }

  static bool _matchesFilter(String type, String filter) {
    if (filter == 'All') {
      return true;
    }
    final normalizedType = type.toLowerCase();
    final normalizedFilter = filter.toLowerCase();
    if (normalizedFilter == 'non-ac') {
      return normalizedType.contains('non-ac') ||
          normalizedType.contains('non ac');
    }
    return normalizedType.contains(normalizedFilter);
  }

  static Stream<List<BusesRecord>> getStream({String filter = 'All'}) async* {
    // Show demo buses immediately so the UI is never stuck on a spinner when
    // Firestore is empty, slow, or denied.
    yield demoBuses(filter: filter);

    // Keep the Firestore query simple. `type` is a string field in this
    // project, so filter client-side instead of using arrayContains.
    try {
      await for (final snapshot in collection.snapshots()) {
        final buses = snapshot.docs
            .map(
              (doc) => BusesRecord._(
                doc.reference,
                doc.data() as Map<String, dynamic>,
              ),
            )
            .where((bus) => _matchesFilter(bus.type, filter))
            .toList();
        yield buses.isEmpty ? demoBuses(filter: filter) : buses;
      }
    } catch (_) {
      yield demoBuses(filter: filter);
    }
  }

  /// Resolve a single bus for detail pages. Falls back to demo data when the
  /// Firestore document is missing (common for local demo refs).
  static Stream<BusesRecord> streamForRef(DocumentReference? busRef) async* {
    BusesRecord? demoMatch;
    if (busRef != null) {
      for (final bus in demoBuses()) {
        if (bus.reference?.id == busRef.id) {
          demoMatch = bus;
          break;
        }
      }
    }
    final fallback = demoMatch ?? demoBuses().first;
    yield fallback;

    if (busRef == null || Firebase.apps.isEmpty) {
      return;
    }

    try {
      await for (final snapshot in busRef.snapshots()) {
        if (snapshot.exists) {
          yield fromSnapshot(snapshot);
        } else {
          yield fallback;
        }
      }
    } catch (_) {
      yield fallback;
    }
  }

  static BusesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BusesRecord._(
          snapshot.reference, snapshot.data() as Map<String, dynamic>);
}
