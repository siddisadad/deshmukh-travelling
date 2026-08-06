import '../../../../core/data/result.dart';
import '../entities/home_dashboard_data.dart';

abstract class HomeDashboardRepository {
  Future<Result<HomeDashboardData>> getDashboardData(String userId);
  Future<Result<void>> saveSearchHistory(SearchHistoryEntity search);
  Future<Result<void>> saveRecentlyViewed(RecentlyViewedEntity item);
  Future<Result<List<String>>> getAiSuggestions(String query);
}
