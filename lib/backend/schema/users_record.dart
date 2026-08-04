import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRecord {
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? uid;
  final DateTime? createdTime;
  final String? phoneNumber;
  final DateTime? dob;
  final String? referralCode;
  final int? rewardPoints;
  final String? referredBy;

  UsersRecord({
    this.email,
    this.displayName,
    this.photoUrl,
    this.uid,
    this.createdTime,
    this.phoneNumber,
    this.dob,
    this.referralCode,
    this.rewardPoints,
    this.referredBy,
  });

  static UsersRecord fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UsersRecord(
      email: data['email'] as String?,
      displayName: data['display_name'] as String?,
      photoUrl: data['photo_url'] as String?,
      uid: data['uid'] as String?,
      createdTime: (data['created_time'] as Timestamp?)?.toDate(),
      phoneNumber: data['phone_number'] as String?,
      dob: (data['dob'] as Timestamp?)?.toDate(),
      referralCode: data['referral_code'] as String?,
      rewardPoints: data['reward_points'] as int?,
      referredBy: data['referred_by'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'dob': dob,
      'referral_code': referralCode,
      'reward_points': rewardPoints,
      'referred_by': referredBy,
    };
  }
}
