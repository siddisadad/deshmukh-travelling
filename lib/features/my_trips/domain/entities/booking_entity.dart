class BookingEntity {
  final String id;
  final String userId;
  final String serviceName;
  final String serviceType;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final double amount;
  final String status;
  final DateTime date;

  BookingEntity({
    required this.id,
    required this.userId,
    required this.serviceName,
    required this.serviceType,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.amount,
    required this.status,
    required this.date,
  });
}
