import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRecord {
  final String id;
  final String hotelId;
  final String type;
  final double price;
  final int capacity;
  final List<String> amenities;
  final bool isAvailable;
  final String image;

  RoomRecord({
    required this.id,
    required this.hotelId,
    required this.type,
    required this.price,
    required this.capacity,
    required this.amenities,
    required this.isAvailable,
    required this.image,
  });

  factory RoomRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return RoomRecord(
      id: doc.id,
      hotelId: data['hotelId'] ?? '',
      type: data['type'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      capacity: data['capacity'] ?? 1,
      amenities: List<String>.from(data['amenities'] ?? []),
      isAvailable: data['isAvailable'] ?? true,
      image: data['image'] ?? '',
    );
  }

  factory RoomRecord.fromMap(Map<String, dynamic> data, String id) {
    return RoomRecord(
      id: id,
      hotelId: data['hotelId'] ?? '',
      type: data['type'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      capacity: data['capacity'] ?? 1,
      amenities: List<String>.from(data['amenities'] ?? []),
      isAvailable: data['isAvailable'] ?? true,
      image: data['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'hotelId': hotelId,
        'type': type,
        'price': price,
        'capacity': capacity,
        'amenities': amenities,
        'isAvailable': isAvailable,
        'image': image,
      };
}
