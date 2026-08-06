import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';
import '../../../backend/schema/wallet_record.dart';

abstract class WalletDataSource {
  Future<WalletRecord?> getWallet(String userId);
  Future<void> updateWalletBalance(String userId, double amount, String type, String description);
}

class FirestoreWalletDataSource implements WalletDataSource {
  final FirebaseFirestore _db;
  final bool useRealFirestore;

  FirestoreWalletDataSource({
    FirebaseFirestore? db,
    this.useRealFirestore = true,
  }) : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<WalletRecord?> getWallet(String userId) async {
    if (!useRealFirestore) {
      return WalletRecord(
        userId: userId,
        balance: 1250.0,
        transactions: [],
      );
    }

    try {
      final doc = await _db.collection('wallets').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        return WalletRecord(
          userId: userId,
          balance: (data['balance'] ?? 0.0).toDouble(),
          transactions: (data['transactions'] as List? ?? []).map((t) {
            return WalletTransaction(
              id: t['id'] ?? '',
              amount: (t['amount'] ?? 0.0).toDouble(),
              type: t['type'] ?? 'credit',
              description: t['description'] ?? '',
              timestamp: (t['timestamp'] as Timestamp).toDate(),
            );
          }).toList(),
        );
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error fetching wallet', originalError: e);
    }
    return null;
  }

  @override
  Future<void> updateWalletBalance(String userId, double amount, String type, String description) async {
    if (!useRealFirestore) return;

    try {
      final docRef = _db.collection('wallets').doc(userId);
      await _db.runTransaction((transaction) async {
        final doc = await transaction.get(docRef);
        double currentBalance = 0.0;
        List transactions = [];

        if (doc.exists) {
          currentBalance = (doc.data()?['balance'] ?? 0.0).toDouble();
          transactions = doc.data()?['transactions'] ?? [];
        }

        final newBalance =
            type == 'credit' ? currentBalance + amount : currentBalance - amount;

        final newTransaction = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'amount': amount,
          'type': type,
          'description': description,
          'timestamp': Timestamp.now(),
        };

        transaction.set(docRef, {
          'userId': userId,
          'balance': newBalance,
          'transactions': [newTransaction, ...transactions],
        });
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Firestore error',
          code: e.code, originalError: e);
    } catch (e) {
      throw AppException('Unexpected error updating wallet balance',
          originalError: e);
    }
  }
}
