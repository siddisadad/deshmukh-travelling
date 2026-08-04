import '/auth/firebase_auth/auth_util.dart';

abstract class UserRepository {
  Future<void> signOut();
  String getCurrentUserId();
}

class FirebaseAuthUserRepository implements UserRepository {
  @override
  Future<void> signOut() {
    return authManager.signOut();
  }

  @override
  String getCurrentUserId() {
    return currentUserUid;
  }
}
