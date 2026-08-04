import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Wallet?> getWallet(String userId);
  Future<void> addMoney(String userId, double amount);
  Future<void> recordTransaction(String userId, WalletTransaction transaction);
}
