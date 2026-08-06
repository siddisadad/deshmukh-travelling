import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/datasources/booking_datasource.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/usecases/get_user_bookings_usecase.dart';
import '../../domain/entities/booking_entity.dart';

final bookingDataSourceProvider = Provider<BookingDataSource>((ref) {
  return FirestoreBookingDataSource();
});

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final dataSource = ref.watch(bookingDataSourceProvider);
  return BookingRepositoryImpl(dataSource);
});

final getUserBookingsUseCaseProvider = Provider<GetUserBookingsUseCase>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return GetUserBookingsUseCase(repository);
});

final userBookingsProvider = FutureProvider.family<List<BookingEntity>, String>((ref, userId) async {
  final useCase = ref.watch(getUserBookingsUseCaseProvider);
  return await useCase.execute(userId);
});
