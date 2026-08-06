import '../../../../core/data/result.dart';
import '../entities/popular_route.dart';

abstract class IRoutesRepository {
  Future<Result<List<PopularRoute>>> getPopularRoutes();
}
