import '../../../../core/data/result.dart';
import '../entities/user_profile.dart';
import '../entities/passenger.dart';
import '../entities/app_notification.dart';

abstract class ProfileRepository {
  Future<Result<UserProfile>> getUserProfile(String uid);
  Future<Result<void>> updateUserProfile(UserProfile profile);
  Future<Result<List<Passenger>>> getSavedPassengers(String uid);
  Future<Result<void>> addPassenger(Passenger passenger);
  Future<Result<List<AppNotification>>> getNotifications(String uid);
  Future<Result<void>> markNotificationAsRead(String notificationId);
  Future<Result<void>> markAllNotificationsAsRead(String uid);
}
