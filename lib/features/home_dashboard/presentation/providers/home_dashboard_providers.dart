import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/home_dashboard_repository.dart';
import '../../data/repositories/home_dashboard_repository_impl.dart';
import '../../domain/usecases/get_home_dashboard_data.dart';
import '../../../../backend/repositories/loyalty_repository.dart';
import '../../domain/entities/home_dashboard_data.dart';

// Repositories
final loyaltyRepositoryProvider = Provider<LoyaltyRepository>((ref) {
  return MockLoyaltyRepository();
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final homeDashboardRepositoryProvider = Provider<HomeDashboardRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  final loyaltyRepo = ref.watch(loyaltyRepositoryProvider);
  if (prefs == null) throw Exception('SharedPreferences not initialized');
  return HomeDashboardRepositoryImpl(prefs, loyaltyRepo);
});

// Use Cases
final getHomeDashboardDataProvider = Provider<GetHomeDashboardData>((ref) {
  final repository = ref.watch(homeDashboardRepositoryProvider);
  return GetHomeDashboardData(repository);
});

// State
final homeDashboardDataProvider = FutureProvider.family<HomeDashboardData, String>((ref, userId) async {
  final useCase = ref.watch(getHomeDashboardDataProvider);
  final result = await useCase.execute(userId);
  return result.fold(
    (data) => data,
    (exception) => throw exception,
  );
});

final selectedServiceProvider = StateProvider<String>((ref) => 'Bus');

final aiSuggestionsProvider = StateProvider<List<String>>((ref) => []);
