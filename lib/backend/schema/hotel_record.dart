import 'package:cloud_firestore/cloud_firestore.dart';

class HotelRecord {
  final String id;
  final String name;
  final String location;
  final String description;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final List<String> amenities;
  final double startingPrice;
  final String city;

  HotelRecord({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.amenities,
    required this.startingPrice,
    required this.city,
  });

  factory HotelRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return HotelRecord(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
      images: List<String>.from(data['images'] ?? []),
      amenities: List<String>.from(data['amenities'] ?? []),
      startingPrice: (data['startingPrice'] ?? 0.0).toDouble(),
      city: data['city'] ?? '',
    );
  }

  factory HotelRecord.fromMap(Map<String, dynamic> data, String id) {
    return HotelRecord(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
      images: List<String>.from(data['images'] ?? []),
      amenities: List<String>.from(data['amenities'] ?? []),
      startingPrice: (data['startingPrice'] ?? 0.0).toDouble(),
      city: data['city'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'location': location,
        'description': description,
        'rating': rating,
        'reviewsCount': reviewsCount,
        'images': images,
        'amenities': amenities,
        'startingPrice': startingPrice,
        'city': city,
      };
}
