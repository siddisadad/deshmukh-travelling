class DestinationEntity {
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final String price;

  DestinationEntity({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.price,
  });
}

class SearchHistoryEntity {
  final String from;
  final String to;

  SearchHistoryEntity({required this.from, required this.to});

  Map<String, String> toMap() => {'from': from, 'to': to};

  factory SearchHistoryEntity.fromMap(Map<String, dynamic> map) {
    return SearchHistoryEntity(
      from: map['from'] ?? '',
      to: map['to'] ?? '',
    );
  }
}

class RecentlyViewedEntity {
  final String title;
  final String subtitle;
  final String image;

  RecentlyViewedEntity({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  Map<String, String> toMap() => {
        'title': title,
        'subtitle': subtitle,
        'image': image,
      };

  factory RecentlyViewedEntity.fromMap(Map<String, dynamic> map) {
    return RecentlyViewedEntity(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      image: map['image'] ?? '',
    );
  }
}

class HomeDashboardData {
  final double walletBalance;
  final int rewardPoints;
  final List<SearchHistoryEntity> recentSearches;
  final List<RecentlyViewedEntity> recentlyViewed;
  final List<DestinationEntity> popularDestinations;
  final List<DestinationEntity> weekendGetaways;
  final List<DestinationEntity> nearbyPlaces;
  final List<DestinationEntity> recommendations;

  HomeDashboardData({
    required this.walletBalance,
    required this.rewardPoints,
    required this.recentSearches,
    required this.recentlyViewed,
    required this.popularDestinations,
    required this.weekendGetaways,
    required this.nearbyPlaces,
    required this.recommendations,
  });
}
