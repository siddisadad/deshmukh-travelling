import 'package:cloud_firestore/cloud_firestore.dart';

class BusRecord {
  final String id;
  final String name;
  final String type;
  final double price;
  final String departureCity;
  final String arrivalCity;
  final String depTime;
  final String arrTime;
  final String rating;
  final String seatsAvailable;

  BusRecord({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.departureCity,
    required this.arrivalCity,
    required this.depTime,
    required this.arrTime,
    required this.rating,
    required this.seatsAvailable,
  });

  factory BusRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return BusRecord(
      id: doc.id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      departureCity: data['departureCity'] ?? '',
      arrivalCity: data['arrivalCity'] ?? '',
      depTime: data['depTime'] ?? '',
      arrTime: data['arrTime'] ?? '',
      rating: data['rating'] ?? '0.0',
      seatsAvailable: data['seatsAvailable'] ?? '0',
    );
  }

  // To support mock data easily
  factory BusRecord.fromMap(Map<String, dynamic> data, String id) {
    return BusRecord(
      id: id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      departureCity: data['departureCity'] ?? '',
      arrivalCity: data['arrivalCity'] ?? '',
      depTime: data['depTime'] ?? '',
      arrTime: data['arrTime'] ?? '',
      rating: data['rating'] ?? '0.0',
      seatsAvailable: data['seatsAvailable'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'price': price,
        'departureCity': departureCity,
        'arrivalCity': arrivalCity,
        'depTime': depTime,
        'arrTime': arrTime,
        'rating': rating,
        'seatsAvailable': seatsAvailable,
      };
}
