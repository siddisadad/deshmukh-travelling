import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../models/wallet_model.dart';

class FirebaseWalletRepository implements WalletRepository {
  final FirebaseFirestore _firestore;

  FirebaseWalletRepository(this._firestore);

  @override
  Future<Wallet?> getWallet(String userId) async {
    final doc = await _firestore.collection('wallets').doc(userId).get();
    if (doc.exists) {
      return WalletModel.fromFirestore(doc);
    }
    return null;
  }

  @override
  Future<void> addMoney(String userId, double amount) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(walletRef);
      if (doc.exists) {
        final currentBalance = (doc.data()?['balance'] ?? 0.0).toDouble();
        transaction.update(walletRef, {'balance': currentBalance + amount});
      } else {
        transaction.set(walletRef, {'balance': amount, 'transactions': []});
      }
    });
  }

  @override
  Future<void> recordTransaction(String userId, WalletTransaction walletTx) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    final model = WalletTransactionModel.fromEntity(walletTx);

    await walletRef.update({
      'transactions': FieldValue.arrayUnion([model.toMap()]),
    });
  }
}
