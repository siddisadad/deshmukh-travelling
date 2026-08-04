import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/pages/seat_selection/components/bus_seat_map.dart';
import 'package:deshmukh_travelling/pages/seat_selection/seat_selection_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BusSeatMap renders all seats', (WidgetTester tester) async {
    final model = SeatSelectionModel();
    // Initialize mock seats
    model.seats = List.generate(24, (index) {
      return Seat(number: (index + 1).toString(), status: 'available', price: 1250.0);
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BusSeatMap(
            model: model,
            onToggleSeat: (_) {},
          ),
        ),
      ),
    );

    // Check if some seat numbers are visible
    expect(find.text('1'), findsOneWidget);
    expect(find.text('24'), findsOneWidget);
  });
}
