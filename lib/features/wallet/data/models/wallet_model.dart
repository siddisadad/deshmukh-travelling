import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/wallet.dart';

class WalletModel extends Wallet {
  WalletModel({
    required super.userId,
    required super.balance,
    required super.transactions,
  });

  factory WalletModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WalletModel(
      userId: doc.id,
      balance: (data['balance'] ?? 0.0).toDouble(),
      transactions: (data['transactions'] as List? ?? []).map((t) {
        return WalletTransactionModel.fromMap(t as Map<String, dynamic>);
      }).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'transactions': transactions.map((t) {
        if (t is WalletTransactionModel) return t.toMap();
        return WalletTransactionModel.fromEntity(t).toMap();
      }).toList(),
    };
  }
}

class WalletTransactionModel extends WalletTransaction {
  WalletTransactionModel({
    required super.id,
    required super.amount,
    required super.type,
    required super.description,
    required super.timestamp,
  });

  factory WalletTransactionModel.fromMap(Map<String, dynamic> map) {
    return WalletTransactionModel(
      id: map['id'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      type: map['type'] == 'debit' ? WalletTransactionType.debit : WalletTransactionType.credit,
      description: map['description'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  factory WalletTransactionModel.fromEntity(WalletTransaction entity) {
    return WalletTransactionModel(
      id: entity.id,
      amount: entity.amount,
      type: entity.type,
      description: entity.description,
      timestamp: entity.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type == WalletTransactionType.debit ? 'debit' : 'credit',
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
