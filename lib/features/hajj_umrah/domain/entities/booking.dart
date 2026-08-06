import 'hajj_package.dart';
import 'pilgrim.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

class Booking {
  final String id;
  final String userId;
  final String packageId;
  final HajjPackage package;
  final List<Pilgrim> pilgrims;
  final double totalAmount;
  final BookingStatus status;
  final DateTime bookingDate;
  final String? remarks;

  Booking({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.package,
    required this.pilgrims,
    required this.totalAmount,
    required this.status,
    required this.bookingDate,
    this.remarks,
  });
}
