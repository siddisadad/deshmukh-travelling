import 'package:cloud_firestore/cloud_firestore.dart';

class TaxiRecord {
  final String id;
  final String type; // e.g., Sedan, SUV, Luxury
  final String vehicleName;
  final double pricePerKm;
  final double baseFare;
  final String image;
  final double rating;
  final int capacity;

  TaxiRecord({
    required this.id,
    required this.type,
    required this.vehicleName,
    required this.pricePerKm,
    required this.baseFare,
    required this.image,
    required this.rating,
    required this.capacity,
  });

  factory TaxiRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return TaxiRecord(
      id: doc.id,
      type: data['type'] ?? '',
      vehicleName: data['vehicleName'] ?? '',
      pricePerKm: (data['pricePerKm'] ?? 0.0).toDouble(),
      baseFare: (data['baseFare'] ?? 0.0).toDouble(),
      image: data['image'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      capacity: data['capacity'] ?? 4,
    );
  }

  factory TaxiRecord.fromMap(Map<String, dynamic> data, String id) {
    return TaxiRecord(
      id: id,
      type: data['type'] ?? '',
      vehicleName: data['vehicleName'] ?? '',
      pricePerKm: (data['pricePerKm'] ?? 0.0).toDouble(),
      baseFare: (data['baseFare'] ?? 0.0).toDouble(),
      image: data['image'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      capacity: data['capacity'] ?? 4,
    );
  }

  Map<String, dynamic> toMap() => {
    'type': type,
    'vehicleName': vehicleName,
    'pricePerKm': pricePerKm,
    'baseFare': baseFare,
    'image': image,
    'rating': rating,
    'capacity': capacity,
  };
}
