import 'package:cloud_firestore/cloud_firestore.dart';

class PackageRecord {
  final String id;
  final String title;
  final String description;
  final List<String> destinations;
  final int durationDays;
  final int durationNights;
  final double price;
  final List<String> images;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<ItineraryDay> itinerary;
  final double rating;
  final int reviewsCount;

  PackageRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.destinations,
    required this.durationDays,
    required this.durationNights,
    required this.price,
    required this.images,
    required this.inclusions,
    required this.exclusions,
    required this.itinerary,
    required this.rating,
    required this.reviewsCount,
  });

  factory PackageRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return PackageRecord(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      destinations: List<String>.from(data['destinations'] ?? []),
      durationDays: data['durationDays'] ?? 0,
      durationNights: data['durationNights'] ?? 0,
      price: (data['price'] ?? 0.0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      inclusions: List<String>.from(data['inclusions'] ?? []),
      exclusions: List<String>.from(data['exclusions'] ?? []),
      itinerary: (data['itinerary'] as List? ?? [])
          .map((item) => ItineraryDay.fromMap(item as Map<String, dynamic>))
          .toList(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
    );
  }

  factory PackageRecord.fromMap(Map<String, dynamic> data, String id) {
    return PackageRecord(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      destinations: List<String>.from(data['destinations'] ?? []),
      durationDays: data['durationDays'] ?? 0,
      durationNights: data['durationNights'] ?? 0,
      price: (data['price'] ?? 0.0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      inclusions: List<String>.from(data['inclusions'] ?? []),
      exclusions: List<String>.from(data['exclusions'] ?? []),
      itinerary: (data['itinerary'] as List? ?? [])
          .map((item) => ItineraryDay.fromMap(item as Map<String, dynamic>))
          .toList(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'destinations': destinations,
    'durationDays': durationDays,
    'durationNights': durationNights,
    'price': price,
    'images': images,
    'inclusions': inclusions,
    'exclusions': exclusions,
    'itinerary': itinerary.map((day) => day.toMap()).toList(),
    'rating': rating,
    'reviewsCount': reviewsCount,
  };
}

class ItineraryDay {
  final int day;
  final String title;
  final String description;
  final List<String> activities;

  ItineraryDay({
    required this.day,
    required this.title,
    required this.description,
    required this.activities,
  });

  factory ItineraryDay.fromMap(Map<String, dynamic> data) {
    return ItineraryDay(
      day: data['day'] ?? 0,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      activities: List<String>.from(data['activities'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
    'day': day,
    'title': title,
    'description': description,
    'activities': activities,
  };
}
