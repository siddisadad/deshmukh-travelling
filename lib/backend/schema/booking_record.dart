import 'package:cloud_firestore/cloud_firestore.dart';

class Passenger {
  final String name;
  final int age;
  final String gender;

  Passenger({required this.name, required this.age, required this.gender});

  Map<String, dynamic> toMap() => {'name': name, 'age': age, 'gender': gender};

  factory Passenger.fromMap(Map<String, dynamic> map) => Passenger(
        name: map['name'] ?? '',
        age: map['age'] ?? 0,
        gender: map['gender'] ?? '',
      );
}

class BookingRecord {
  final String? id;
  final String userId;
  final String busId;
  final String busName;
  final String busType;
  final String departureCity;
  final String arrivalCity;
  final String depTime;
  final String arrTime;
  final List<String> seatNumbers;
  final List<Passenger> passengers;
  final double totalAmount;
  final String status;
  final DateTime timestamp;

  BookingRecord({
    this.id,
    required this.userId,
    required this.busId,
    required this.busName,
    required this.busType,
    required this.departureCity,
    required this.arrivalCity,
    required this.depTime,
    required this.arrTime,
    required this.seatNumbers,
    required this.passengers,
    required this.totalAmount,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'busId': busId,
      'busName': busName,
      'busType': busType,
      'departureCity': departureCity,
      'arrivalCity': arrivalCity,
      'depTime': depTime,
      'arrTime': arrTime,
      'seatNumbers': seatNumbers,
      'passengers': passengers.map((p) => p.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'timestamp': timestamp,
    };
  }

  factory BookingRecord.fromMap(Map<String, dynamic> data) {
    return BookingRecord(
      id: data['id'],
      userId: data['userId'] ?? '',
      busId: data['busId'] ?? '',
      busName: data['busName'] ?? '',
      busType: data['busType'] ?? '',
      departureCity: data['departureCity'] ?? '',
      arrivalCity: data['arrivalCity'] ?? '',
      depTime: data['depTime'] ?? '',
      arrTime: data['arrTime'] ?? '',
      seatNumbers: List<String>.from(data['seatNumbers'] ?? []),
      passengers: (data['passengers'] as List? ?? [])
          .map((p) => Passenger.fromMap(p as Map<String, dynamic>))
          .toList(),
      totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
      status: data['status'] ?? '',
      timestamp: data['timestamp'] is Timestamp
          ? (data['timestamp'] as Timestamp).toDate()
          : (data['timestamp'] is DateTime ? data['timestamp'] as DateTime : DateTime.now()),
    );
  }

  factory BookingRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return BookingRecord(
      id: doc.id,
      userId: data['userId'] ?? '',
      busId: data['busId'] ?? '',
      busName: data['busName'] ?? '',
      busType: data['busType'] ?? '',
      departureCity: data['departureCity'] ?? '',
      arrivalCity: data['arrivalCity'] ?? '',
      depTime: data['depTime'] ?? '',
      arrTime: data['arrTime'] ?? '',
      seatNumbers: List<String>.from(data['seatNumbers'] ?? []),
      passengers: (data['passengers'] as List? ?? [])
          .map((p) => Passenger.fromMap(p as Map<String, dynamic>))
          .toList(),
      totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
      status: data['status'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
