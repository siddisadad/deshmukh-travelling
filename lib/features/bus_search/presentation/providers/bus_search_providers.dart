import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/datasources/bus_datasource.dart';
import '../../domain/repositories/bus_search_repository.dart';
import '../../data/repositories/bus_search_repository_impl.dart';
import '../../domain/usecases/search_buses_usecase.dart';
import '../../domain/entities/bus_search_entity.dart';

final busDataSourceProvider = Provider<BusDataSource>((ref) {
  return FirestoreBusDataSource();
});

final busSearchRepositoryProvider = Provider<BusSearchRepository>((ref) {
  final dataSource = ref.watch(busDataSourceProvider);
  return BusSearchRepositoryImpl(dataSource);
});

final searchBusesUseCaseProvider = Provider<SearchBusesUseCase>((ref) {
  final repository = ref.watch(busSearchRepositoryProvider);
  return SearchBusesUseCase(repository);
});

class BusSearchParams {
  final String from;
  final String to;
  final DateTime? date;

  BusSearchParams({required this.from, required this.to, this.date});
}

final busSearchResultsProvider = FutureProvider.family<List<BusSearchEntity>, BusSearchParams>((ref, params) async {
  final useCase = ref.watch(searchBusesUseCaseProvider);
  return await useCase.execute(from: params.from, to: params.to, date: params.date);
});
