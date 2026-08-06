import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/features/home_dashboard/data/repositories/home_dashboard_repository_impl.dart';
import 'package:deshmukh_travelling/backend/repositories/loyalty_repository.dart';
import 'package:deshmukh_travelling/backend/schema/wallet_record.dart';
import 'package:deshmukh_travelling/backend/schema/reward_record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deshmukh_travelling/backend/schema/coupon_record.dart';

class MockLoyaltyRepository implements LoyaltyRepository {
  @override
  Future<WalletRecord> getWallet(String userId) async {
    return WalletRecord(userId: userId, balance: 500.0, transactions: []);
  }

  @override
  Future<RewardRecord> getRewards(String userId) async {
    return RewardRecord(userId: userId, points: 100);
  }

  @override
  Future<CouponRecord?> getCoupon(String code) async => null;

  @override
  Future<void> updateWallet(String userId, double amount, String type, String description) async {}
}

void main() {
  group('HomeDashboardRepositoryImpl Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('getDashboardData returns Success with HomeDashboardData', () async {
      final repository = HomeDashboardRepositoryImpl(prefs, MockLoyaltyRepository());
      final result = await repository.getDashboardData('user1');

      expect(result.isSuccess, true);
      expect(result.data?.walletBalance, 500.0);
      expect(result.data?.rewardPoints, 100);
    });

    test('getAiSuggestions returns Success with suggestions', () async {
      final repository = HomeDashboardRepositoryImpl(prefs, MockLoyaltyRepository());
      final result = await repository.getAiSuggestions('Mumbai');

      expect(result.isSuccess, true);
      expect(result.data, isNotEmpty);
      expect(result.data?.any((s) => s.contains('Mumbai')), true);
    });
  });
}
