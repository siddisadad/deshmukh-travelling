class BusSearchEntity {
  final String id;
  final String name;
  final String type;
  final double price;
  final String departureCity;
  final String arrivalCity;
  final String departureTime;
  final String arrivalTime;
  final String rating;
  final int seatsAvailable;

  BusSearchEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.rating,
    required this.seatsAvailable,
  });
}
