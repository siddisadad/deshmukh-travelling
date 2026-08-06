import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/datasources/hotel_datasource.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../../data/repositories/hotel_repository_impl.dart';
import '../../domain/usecases/search_hotels_usecase.dart';
import '../../domain/entities/hotel_entity.dart';

final hotelDataSourceProvider = Provider<HotelDataSource>((ref) {
  return FirestoreHotelDataSource();
});

final hotelRepositoryProvider = Provider<HotelRepository>((ref) {
  final dataSource = ref.watch(hotelDataSourceProvider);
  return HotelRepositoryImpl(dataSource);
});

final searchHotelsUseCaseProvider = Provider<SearchHotelsUseCase>((ref) {
  final repository = ref.watch(hotelRepositoryProvider);
  return SearchHotelsUseCase(repository);
});

final hotelSearchResultsProvider = FutureProvider.family<List<HotelEntity>, String>((ref, city) async {
  final useCase = ref.watch(searchHotelsUseCaseProvider);
  return await useCase.execute(city);
});
