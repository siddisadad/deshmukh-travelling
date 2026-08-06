import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/auth/firebase_auth/auth_util.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/passenger.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../../../core/data/result.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UserProfileNotifier(repository);
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final ProfileRepository _repository;

  UserProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    if (currentUserUid.isEmpty) {
      state = const AsyncValue.data(null);
      return;
    }
    state = const AsyncValue.loading();
    final result = await _repository.getUserProfile(currentUserUid);
    result.fold(
      (data) => state = AsyncValue.data(data),
      (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<void>> updateProfile(UserProfile profile) async {
    final result = await _repository.updateUserProfile(profile);
    if (result.isSuccess) {
      state = AsyncValue.data(profile);
    }
    return result;
  }
}

final savedPassengersProvider = StateNotifierProvider<PassengersNotifier, AsyncValue<List<Passenger>>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return PassengersNotifier(repository);
});

class PassengersNotifier extends StateNotifier<AsyncValue<List<Passenger>>> {
  final ProfileRepository _repository;

  PassengersNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPassengers();
  }

  Future<void> loadPassengers() async {
    if (currentUserUid.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    final result = await _repository.getSavedPassengers(currentUserUid);
    result.fold(
      (data) => state = AsyncValue.data(data),
      (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<void>> addPassenger(Passenger passenger) async {
    final result = await _repository.addPassenger(passenger);
    if (result.isSuccess) {
      await loadPassengers();
    }
    return result;
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsNotifier, AsyncValue<List<AppNotification>>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return NotificationsNotifier(repository);
});

class NotificationsNotifier extends StateNotifier<AsyncValue<List<AppNotification>>> {
  final ProfileRepository _repository;

  NotificationsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    if (currentUserUid.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    final result = await _repository.getNotifications(currentUserUid);
    result.fold(
      (data) => state = AsyncValue.data(data),
      (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _repository.markNotificationAsRead(notificationId);
    if (result.isSuccess) {
      state = state.whenData((list) => list.map((n) => n.id == notificationId ? (n..isRead = true) : n).toList());
    }
  }

  Future<void> markAllAsRead() async {
    final result = await _repository.markAllNotificationsAsRead(currentUserUid);
    if (result.isSuccess) {
      state = state.whenData((list) => list.map((n) => n..isRead = true).toList());
    }
  }
}
