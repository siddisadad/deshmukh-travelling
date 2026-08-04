class WalletRecord {
  final String userId;
  final double balance;
  final List<WalletTransaction> transactions;

  WalletRecord({
    required this.userId,
    required this.balance,
    required this.transactions,
  });
}

class WalletTransaction {
  final String id;
  final double amount;
  final String type; // 'credit', 'debit'
  final String description;
  final DateTime timestamp;

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
  });
}
