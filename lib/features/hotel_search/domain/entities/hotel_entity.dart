class HotelEntity {
  final String id;
  final String name;
  final String location;
  final String description;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final List<String> amenities;
  final double startingPrice;
  final String city;

  HotelEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.amenities,
    required this.startingPrice,
    required this.city,
  });
}

class RoomEntity {
  final String id;
  final String hotelId;
  final String type;
  final double price;
  final int capacity;
  final List<String> amenities;
  final bool isAvailable;
  final String image;

  RoomEntity({
    required this.id,
    required this.hotelId,
    required this.type,
    required this.price,
    required this.capacity,
    required this.amenities,
    required this.isAvailable,
    required this.image,
  });
}
