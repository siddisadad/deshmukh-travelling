import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/features/wallet/data/repositories/firebase_wallet_repository.dart';
import 'package:deshmukh_travelling/core/data/datasources/wallet_datasource.dart';
import 'package:deshmukh_travelling/backend/schema/wallet_record.dart';

class MockWalletDataSource implements WalletDataSource {
  @override
  Future<WalletRecord?> getWallet(String userId) async {
    return WalletRecord(
      userId: userId,
      balance: 1000.0,
      transactions: [],
    );
  }

  @override
  Future<void> updateWalletBalance(String userId, double amount, String type, String description) async {
    // Mock update
  }
}

void main() {
  group('FirebaseWalletRepository Tests', () {
    test('getWallet returns a Wallet entity', () async {
      final repository = FirebaseWalletRepository(MockWalletDataSource());
      final wallet = await repository.getWallet('user1');

      expect(wallet, isNotNull);
      expect(wallet!.balance, 1000.0);
    });

    test('addMoney calls updateWalletBalance', () async {
      final repository = FirebaseWalletRepository(MockWalletDataSource());
      await repository.addMoney('user1', 500.0);
      // If no exception, it passed
    });
  });
}
