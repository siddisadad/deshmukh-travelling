import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewRecord {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String referenceId; // HotelId, PackageId, or BusId
  final String referenceType; // 'hotel', 'package', 'bus'
  final double rating;
  final String comment;
  final DateTime createdAt;

  ReviewRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.referenceId,
    required this.referenceType,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ReviewRecord(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      referenceId: data['referenceId'] ?? '',
      referenceType: data['referenceType'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      comment: data['comment'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'userName': userName,
    'userImage': userImage,
    'referenceId': referenceId,
    'referenceType': referenceType,
    'rating': rating,
    'comment': comment,
    'createdAt': createdAt,
  };
}
