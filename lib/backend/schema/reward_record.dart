class RewardRecord {
  final String userId;
  final int points;

  RewardRecord({
    required this.userId,
    required this.points,
  });

  double get cashValue => points * 0.1; // 10 points = ₹1
}
