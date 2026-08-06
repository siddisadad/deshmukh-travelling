import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deshmukh_travelling/backend/firebase/firestore_service.dart';
import 'package:deshmukh_travelling/features/bus_booking/presentation/widgets/bus_seat_map.dart';
import 'package:deshmukh_travelling/features/bus_booking/domain/repositories/bus_repository.dart';
import 'package:deshmukh_travelling/features/bus_booking/presentation/providers/booking_providers.dart';
import 'package:deshmukh_travelling/core/data/result.dart';
import 'package:deshmukh_travelling/backend/schema/bus_record.dart';
import 'package:deshmukh_travelling/backend/schema/booking_record.dart';

class FakeBusRepository implements BusRepository {
  @override
  Future<Result<List<String>>> getBookedSeats(String busId) async {
    return Result.success(['2B', '5C']);
  }

  @override
  Future<Result<List<BusRecord>>> searchBuses({required String from, required String to, DateTime? date}) async {
    return Result.success([]);
  }

  @override
  Future<Result<BookingRecord>> createBooking(BookingRecord booking) async {
    return Result.failure(AppException('Not implemented'));
  }
}

void main() {
  setUp(() {
    FirestoreService.useRealFirestore = false;
  });

  testWidgets('BusSeatMap renders all seats', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          busRepositoryProvider.overrideWithValue(FakeBusRepository()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: BusSeatMap(
              busId: 'bus1',
            ),
          ),
        ),
      ),
    );

    // Initial load
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100)); // Wait for mock delay if any

    // Check if some seat numbers are visible (e.g., 1A, 6D based on the loop)
    expect(find.text('1A'), findsOneWidget);
    expect(find.text('6D'), findsOneWidget);
  });
}
