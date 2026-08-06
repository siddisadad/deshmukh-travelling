import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/users_record.dart';
import '../../../backend/schema/passenger_record.dart';
import '../../../backend/schema/reward_record.dart';

abstract class UserDataSource {
  Future<UsersRecord?> getUser(String uid);
  Future<void> createUser(UsersRecord user);
  Future<List<PassengerRecord>> fetchSavedPassengers(String userId);
  Future<void> savePassenger(PassengerRecord passenger);
  Future<void> addLoyaltyPoints(String userId, int points);
  Future<RewardRecord?> getRewards(String userId);
  Future<void> redeemPoints(String userId, int pointsToRedeem);
}

class FirestoreUserDataSource implements UserDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreUserDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<UsersRecord?> getUser(String uid) async {
    if (!useRealFirestore) {
      return UsersRecord(
        uid: uid,
        email: 'test@example.com',
        displayName: 'Test User',
      );
    }
    try {
      final doc = await _db.collection('users').doc(uid).get();
      return doc.exists ? UsersRecord.fromFirestore(doc) : null;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching user', originalError: e);
    }
  }

  @override
  Future<void> createUser(UsersRecord user) async {
    if (!useRealFirestore) return;
    try {
      await _db.collection('users').doc(user.uid).set(user.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error creating user', originalError: e);
    }
  }

  @override
  Future<List<PassengerRecord>> fetchSavedPassengers(String userId) async {
    if (!useRealFirestore) return [];
    try {
      final snapshot = await _db
          .collection('saved_passengers')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs
          .map((doc) => PassengerRecord.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching saved passengers',
          originalError: e);
    }
  }

  @override
  Future<void> savePassenger(PassengerRecord passenger) async {
    if (!useRealFirestore) return;
    try {
      await _db.collection('saved_passengers').add(passenger.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error saving passenger', originalError: e);
    }
  }

  @override
  Future<void> addLoyaltyPoints(String userId, int points) async {
    if (!useRealFirestore) return;
    try {
      await _db.collection('users').doc(userId).update({
        'loyaltyPoints': FieldValue.increment(points),
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error updating loyalty points',
          originalError: e);
    }
  }

  @override
  Future<RewardRecord?> getRewards(String userId) async {
    if (!useRealFirestore) return RewardRecord(userId: userId, points: 250);
    try {
      final doc = await _db.collection('users').doc(userId).get();
      return RewardRecord(
          userId: userId, points: doc.data()?['loyaltyPoints'] ?? 0);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching rewards', originalError: e);
    }
  }

  @override
  Future<void> redeemPoints(String userId, int pointsToRedeem) async {
    if (!useRealFirestore) return;
    try {
      await _db.collection('users').doc(userId).update({
        'loyaltyPoints': FieldValue.increment(-pointsToRedeem),
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error redeeming points', originalError: e);
    }
  }
}
