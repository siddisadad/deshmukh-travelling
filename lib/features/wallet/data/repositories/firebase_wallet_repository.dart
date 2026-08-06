import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../../../core/data/datasources/wallet_datasource.dart';

class FirebaseWalletRepository implements WalletRepository {
  final WalletDataSource _dataSource;

  FirebaseWalletRepository(this._dataSource);

  @override
  Future<Wallet?> getWallet(String userId) async {
    final record = await _dataSource.getWallet(userId);
    if (record == null) return null;

    return Wallet(
      userId: record.userId,
      balance: record.balance,
      transactions: record.transactions.map((t) => WalletTransaction(
        id: t.id,
        amount: t.amount,
        type: t.type == 'credit' ? WalletTransactionType.credit : WalletTransactionType.debit,
        description: t.description,
        timestamp: t.timestamp,
      )).toList(),
    );
  }

  @override
  Future<void> addMoney(String userId, double amount) async {
    await _dataSource.updateWalletBalance(userId, amount, 'credit', 'Added money to wallet');
  }

  @override
  Future<void> recordTransaction(String userId, WalletTransaction walletTx) async {
    await _dataSource.updateWalletBalance(
      userId,
      walletTx.amount,
      walletTx.type == WalletTransactionType.credit ? 'credit' : 'debit',
      walletTx.description
    );
  }
}
