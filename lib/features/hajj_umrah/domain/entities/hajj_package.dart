enum PackageType { hajj, umrah }

class HajjPackage {
  final String id;
  final String title;
  final String description;
  final PackageType type;
  final double price;
  final DateTime startDate;
  final DateTime? endDate;
  final String duration;
  final List<String> images;
  final List<String> amenities;
  final List<String> includes;
  final List<String> excludes;
  final String? makkahHotel;
  final String? madinahHotel;
  final String? hotelInfo;
  final String? flightInfo;
  final int seatsLeft;
  final List<ItineraryDay> itinerary;
  final bool isPremium;

  HajjPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.price,
    required this.startDate,
    this.endDate,
    required this.duration,
    required this.images,
    this.amenities = const [],
    this.includes = const [],
    this.excludes = const [],
    this.makkahHotel,
    this.madinahHotel,
    this.hotelInfo,
    this.flightInfo,
    this.seatsLeft = 0,
    this.itinerary = const [],
    this.isPremium = false,
  });
}

class ItineraryDay {
  final int day;
  final String title;
  final String description;
  final String location;

  ItineraryDay({
    required this.day,
    required this.title,
    required this.description,
    required this.location,
  });
}
