import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase/firestore_service.dart';
import '../../../../core/data/result.dart';
import '../../data/repositories/package_repository_impl.dart';
import '../../domain/entities/package_record.dart';
import '../../domain/repositories/package_repository.dart';

final packageRepositoryProvider = Provider<PackageRepository>((ref) {
  return PackageRepositoryImpl(FirestoreService());
});

final packagesProvider = FutureProvider<Result<List<PackageRecord>>>((ref) async {
  return ref.watch(packageRepositoryProvider).getPackages();
});

final packageDetailsProvider = FutureProvider.family<Result<PackageRecord>, String>((ref, id) async {
  return ref.watch(packageRepositoryProvider).getPackageDetails(id);
});

class BookingState {
  final int travelerCount;
  final DateTime? selectedDate;
  final bool isLoading;

  BookingState({
    this.travelerCount = 1,
    this.selectedDate,
    this.isLoading = false,
  });

  BookingState copyWith({
    int? travelerCount,
    DateTime? selectedDate,
    bool? isLoading,
  }) {
    return BookingState(
      travelerCount: travelerCount ?? this.travelerCount,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  final PackageRepository _repository;

  BookingNotifier(this._repository) : super(BookingState());

  void setTravelerCount(int count) {
    state = state.copyWith(travelerCount: count);
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  Future<Result<String>> bookPackage(PackageRecord package) async {
    if (state.selectedDate == null) {
      return Result.failure(AppException('Please select a date'));
    }
    state = state.copyWith(isLoading: true);
    final result = await _repository.bookPackage(
      package: package,
      travelerCount: state.travelerCount,
      selectedDate: state.selectedDate!,
    );
    state = state.copyWith(isLoading: false);
    return result;
  }
}

final bookingProvider = StateNotifierProvider.autoDispose<BookingNotifier, BookingState>((ref) {
  return BookingNotifier(ref.watch(packageRepositoryProvider));
});
