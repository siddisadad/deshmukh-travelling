class CouponRecord {
  final String code;
  final double discountAmount;
  final double minOrderValue;
  final DateTime expiryDate;

  CouponRecord({
    required this.code,
    required this.discountAmount,
    required this.minOrderValue,
    required this.expiryDate,
  });

  bool isValid(double orderValue) {
    return orderValue >= minOrderValue && expiryDate.isAfter(DateTime.now());
  }
}
