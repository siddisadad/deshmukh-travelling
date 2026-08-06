import '../../../../backend/schema/bus_record.dart';

class BusLocation {
  final BusRecord bus;
  final double latitude;
  final double longitude;
  final String driverName;
  final String driverPhone;
  final String busNumber;

  BusLocation({
    required this.bus,
    required this.latitude,
    required this.longitude,
    required this.driverName,
    required this.driverPhone,
    required this.busNumber,
  });
}
