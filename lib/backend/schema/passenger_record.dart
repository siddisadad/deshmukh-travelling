import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerRecord {
  final String? id;
  final String userId;
  final String name;
  final int age;
  final String gender;
  final String relation;

  PassengerRecord({
    this.id,
    required this.userId,
    required this.name,
    required this.age,
    required this.gender,
    required this.relation,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'age': age,
      'gender': gender,
      'relation': relation,
    };
  }

  factory PassengerRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return PassengerRecord(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      relation: data['relation'] ?? '',
    );
  }

  factory PassengerRecord.fromMap(Map<String, dynamic> data, String id) {
    return PassengerRecord(
      id: id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      relation: data['relation'] ?? '',
    );
  }
}
