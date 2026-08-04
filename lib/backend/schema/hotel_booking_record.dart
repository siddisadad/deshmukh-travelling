import 'package:cloud_firestore/cloud_firestore.dart';

class HotelBookingRecord {
  final String id;
  final String userId;
  final String hotelId;
  final String roomId;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;
  final String status; // e.g., 'confirmed', 'cancelled', 'pending'
  final int guestCount;
  final DateTime createdAt;

  HotelBookingRecord({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.status,
    required this.guestCount,
    required this.createdAt,
  });

  factory HotelBookingRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return HotelBookingRecord(
      id: doc.id,
      userId: data['userId'] ?? '',
      hotelId: data['hotelId'] ?? '',
      roomId: data['roomId'] ?? '',
      checkIn: (data['checkIn'] as Timestamp).toDate(),
      checkOut: (data['checkOut'] as Timestamp).toDate(),
      totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
      status: data['status'] ?? 'pending',
      guestCount: data['guestCount'] ?? 1,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'hotelId': hotelId,
        'roomId': roomId,
        'checkIn': checkIn,
        'checkOut': checkOut,
        'totalPrice': totalPrice,
        'status': status,
        'guestCount': guestCount,
        'createdAt': createdAt,
      };
}
