import 'package:cloud_firestore/cloud_firestore.dart';

class RentalRecord {
  final String id;
  final String vehicleName;
  final String type; // SUV, Sedan, Hatchback
  final double pricePerDay;
  final String transmission; // Manual, Automatic
  final String fuelType; // Petrol, Diesel, Electric
  final int capacity;
  final String image;
  final double rating;

  RentalRecord({
    required this.id,
    required this.vehicleName,
    required this.type,
    required this.pricePerDay,
    required this.transmission,
    required this.fuelType,
    required this.capacity,
    required this.image,
    required this.rating,
  });

  factory RentalRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return RentalRecord(
      id: doc.id,
      vehicleName: data['vehicleName'] ?? '',
      type: data['type'] ?? '',
      pricePerDay: (data['pricePerDay'] ?? 0.0).toDouble(),
      transmission: data['transmission'] ?? 'Manual',
      fuelType: data['fuelType'] ?? 'Petrol',
      capacity: data['capacity'] ?? 5,
      image: data['image'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'vehicleName': vehicleName,
    'type': type,
    'pricePerDay': pricePerDay,
    'transmission': transmission,
    'fuelType': fuelType,
    'capacity': capacity,
    'image': image,
    'rating': rating,
  };
}
