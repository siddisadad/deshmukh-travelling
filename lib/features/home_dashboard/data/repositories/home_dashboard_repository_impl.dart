import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/result.dart';
import '../../domain/entities/home_dashboard_data.dart';
import '../../domain/repositories/home_dashboard_repository.dart';
import '../../../../backend/repositories/loyalty_repository.dart';

class HomeDashboardRepositoryImpl implements HomeDashboardRepository {
  final SharedPreferences _prefs;
  final LoyaltyRepository _loyaltyRepository;

  HomeDashboardRepositoryImpl(this._prefs, this._loyaltyRepository);

  @override
  Future<Result<HomeDashboardData>> getDashboardData(String userId) async {
    try {
      final wallet = await _loyaltyRepository.getWallet(userId);
      final rewards = await _loyaltyRepository.getRewards(userId);

      final recentSearches = _getRecentSearches();
      final recentlyViewed = _getRecentlyViewed();

      final data = HomeDashboardData(
        walletBalance: wallet.balance,
        rewardPoints: rewards.points,
        recentSearches: recentSearches,
        recentlyViewed: recentlyViewed,
        popularDestinations: _mockPopularDestinations,
        weekendGetaways: _mockWeekendGetaways,
        nearbyPlaces: _mockNearbyPlaces,
        recommendations: _mockRecommendations,
      );
      return Result.success(data);
    } catch (e) {
      return Result.failure(AppException('Failed to fetch dashboard data', originalError: e));
    }
  }

  List<SearchHistoryEntity> _getRecentSearches() {
    final String? searchesJson = _prefs.getString('recent_searches');
    if (searchesJson == null) return [];
    final List<dynamic> decoded = json.decode(searchesJson);
    return decoded.map((item) => SearchHistoryEntity.fromMap(Map<String, dynamic>.from(item))).toList();
  }

  List<RecentlyViewedEntity> _getRecentlyViewed() {
    final String? viewedJson = _prefs.getString('recently_viewed');
    if (viewedJson == null) return [];
    final List<dynamic> decoded = json.decode(viewedJson);
    return decoded.map((item) => RecentlyViewedEntity.fromMap(Map<String, dynamic>.from(item))).toList();
  }

  @override
  Future<Result<void>> saveSearchHistory(SearchHistoryEntity search) async {
    try {
      final searches = _getRecentSearches();
      searches.removeWhere((s) => s.from == search.from && s.to == search.to);
      searches.insert(0, search);

      final limited = searches.length > 5 ? searches.sublist(0, 5) : searches;
      await _prefs.setString('recent_searches', json.encode(limited.map((e) => e.toMap()).toList()));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheException('Failed to save search history', originalError: e));
    }
  }

  @override
  Future<Result<void>> saveRecentlyViewed(RecentlyViewedEntity item) async {
    try {
      final items = _getRecentlyViewed();
      items.removeWhere((i) => i.title == item.title);
      items.insert(0, item);

      final limited = items.length > 5 ? items.sublist(0, 5) : items;
      await _prefs.setString('recently_viewed', json.encode(limited.map((e) => e.toMap()).toList()));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheException('Failed to save recently viewed', originalError: e));
    }
  }

  @override
  Future<Result<List<String>>> getAiSuggestions(String query) async {
    try {
      if (query.length < 2) return Result.success([]);

      // Simulate AI logic
      final allSuggestions = [
        'Best beaches in Goa for family',
        'Cheap hotels in Mumbai near airport',
        'Weekend trips from Pune for couples',
        'Luxury bus from Ahmedabad to Surat',
        'Trekking packages in Manali',
        'Hotels with sea view in Mumbai',
        'Direct bus to Nashik',
      ];
      final suggestions = allSuggestions
          .where((s) => s.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Result.success(suggestions);
    } catch (e) {
      return Result.failure(AppException('Failed to get AI suggestions', originalError: e));
    }
  }

  final List<DestinationEntity> _mockPopularDestinations = [
    DestinationEntity(
      title: 'Goa',
      subtitle: 'Beaches & Nightlife',
      image: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=500&q=80',
      rating: 4.8,
      price: 'Starts from ₹2,999',
    ),
    DestinationEntity(
      title: 'Manali',
      subtitle: 'Mountains & Snow',
      image: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=500&q=80',
      rating: 4.7,
      price: 'Starts from ₹3,499',
    ),
  ];

  final List<DestinationEntity> _mockWeekendGetaways = [
    DestinationEntity(
      title: 'Lonavala',
      subtitle: 'Hill Station near Pune',
      image: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500&q=80',
      rating: 4.5,
      price: '₹999 / person',
    ),
  ];

  final List<DestinationEntity> _mockNearbyPlaces = [
    DestinationEntity(
      title: 'Gateway of India',
      subtitle: '2.5 km away',
      image: 'https://images.unsplash.com/photo-1587135941948-670b381f08ce?w=500&q=80',
      rating: 4.8,
      price: '',
    ),
  ];

  final List<DestinationEntity> _mockRecommendations = [
    DestinationEntity(
      title: 'Luxury Bus to Udaipur',
      subtitle: 'Sleeper • AC • WiFi',
      image: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500&q=80',
      rating: 4.9,
      price: '₹1,200',
    ),
  ];
}
