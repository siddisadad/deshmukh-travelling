import '../schema/coupon_record.dart';
import '../schema/wallet_record.dart';
import '../schema/reward_record.dart';

abstract class LoyaltyRepository {
  Future<CouponRecord?> getCoupon(String code);
  Future<WalletRecord> getWallet(String userId);
  Future<RewardRecord> getRewards(String userId);
  Future<void> updateWallet(String userId, double amount, String type, String description);
}

class MockLoyaltyRepository implements LoyaltyRepository {
  @override
  Future<CouponRecord?> getCoupon(String code) async {
    if (code.toUpperCase() == 'FLASH20') {
      return CouponRecord(
        code: 'FLASH20',
        discountAmount: 100.0,
        minOrderValue: 500.0,
        expiryDate: DateTime.now().add(const Duration(days: 30)),
      );
    }
    return null;
  }

  @override
  Future<WalletRecord> getWallet(String userId) async {
    return WalletRecord(
      userId: userId,
      balance: 500.0,
      transactions: [
        WalletTransaction(
          id: 'tx1',
          amount: 500.0,
          type: 'credit',
          description: 'Welcome Bonus',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
    );
  }

  @override
  Future<RewardRecord> getRewards(String userId) async {
    return RewardRecord(userId: userId, points: 250);
  }

  @override
  Future<void> updateWallet(String userId, double amount, String type, String description) async {
    // Mock update
  }
}
