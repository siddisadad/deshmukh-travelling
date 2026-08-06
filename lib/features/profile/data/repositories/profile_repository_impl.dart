import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/result.dart';
import '../../../../backend/schema/users_record.dart';
import '../../../../backend/schema/passenger_record.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/passenger.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<UserProfile>> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final record = UsersRecord.fromFirestore(doc);
        return Result.success(UserProfile(
          uid: record.uid ?? uid,
          email: record.email,
          displayName: record.displayName,
          photoUrl: record.photoUrl,
          phoneNumber: record.phoneNumber,
          dob: record.dob,
          referralCode: record.referralCode,
          rewardPoints: record.rewardPoints,
          referredBy: record.referredBy,
          createdTime: record.createdTime,
        ));
      } else {
        return Result.failure(AppException('User profile not found'));
      }
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch user profile', originalError: e));
    }
  }

  @override
  Future<Result<void>> updateUserProfile(UserProfile profile) async {
    try {
      final record = UsersRecord(
        uid: profile.uid,
        email: profile.email,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        phoneNumber: profile.phoneNumber,
        dob: profile.dob,
        referralCode: profile.referralCode,
        rewardPoints: profile.rewardPoints,
        referredBy: profile.referredBy,
        createdTime: profile.createdTime,
      );
      await _firestore.collection('users').doc(profile.uid).update(record.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to update user profile', originalError: e));
    }
  }

  @override
  Future<Result<List<Passenger>>> getSavedPassengers(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('saved_passengers')
          .where('userId', isEqualTo: uid)
          .get();

      final passengers = snapshot.docs.map((doc) {
        final record = PassengerRecord.fromFirestore(doc);
        return Passenger(
          id: record.id,
          userId: record.userId,
          name: record.name,
          age: record.age,
          gender: record.gender,
          relation: record.relation,
        );
      }).toList();
      return Result.success(passengers);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch saved passengers', originalError: e));
    }
  }

  @override
  Future<Result<void>> addPassenger(Passenger passenger) async {
    try {
      final record = PassengerRecord(
        userId: passenger.userId,
        name: passenger.name,
        age: passenger.age,
        gender: passenger.gender,
        relation: passenger.relation,
      );
      await _firestore.collection('saved_passengers').add(record.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to add passenger', originalError: e));
    }
  }

  @override
  Future<Result<List<AppNotification>>> getNotifications(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .get();

      final notifications = snapshot.docs.map((doc) {
        final data = doc.data();
        return AppNotification(
          id: doc.id,
          title: data['title'] ?? '',
          message: data['message'] ?? '',
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          type: data['type'] ?? 'general',
          isRead: data['isRead'] ?? false,
        );
      }).toList();
      return Result.success(notifications);
    } catch (e) {
      return Result.failure(ServerException('Failed to fetch notifications', originalError: e));
    }
  }

  @override
  Future<Result<void>> markNotificationAsRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({'isRead': true});
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to mark notification as read', originalError: e));
    }
  }

  @override
  Future<Result<void>> markAllNotificationsAsRead(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: uid)
          .where('isRead', isEqualTo: false)
          .get();

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerException('Failed to mark all notifications as read', originalError: e));
    }
  }
}
