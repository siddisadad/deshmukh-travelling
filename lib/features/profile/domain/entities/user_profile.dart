class UserProfile {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final DateTime? dob;
  final String? referralCode;
  final int? rewardPoints;
  final String? referredBy;
  final DateTime? createdTime;

  UserProfile({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.dob,
    this.referralCode,
    this.rewardPoints,
    this.referredBy,
    this.createdTime,
  });

  UserProfile copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    DateTime? dob,
    String? photoUrl,
  }) {
    return UserProfile(
      uid: uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      referralCode: referralCode,
      rewardPoints: rewardPoints,
      referredBy: referredBy,
      createdTime: createdTime,
    );
  }
}
