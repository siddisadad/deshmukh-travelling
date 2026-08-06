import '../../../../core/data/result.dart';
import '../entities/home_dashboard_data.dart';
import '../repositories/home_dashboard_repository.dart';

class GetHomeDashboardData {
  final HomeDashboardRepository repository;

  GetHomeDashboardData(this.repository);

  Future<Result<HomeDashboardData>> execute(String userId) {
    return repository.getDashboardData(userId);
  }
}
