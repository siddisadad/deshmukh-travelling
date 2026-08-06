import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/core/design_system/components/app_button.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('Renders with correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              onPressed: () {},
              text: 'Click Me',
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('Triggers callback when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              onPressed: () => tapped = true,
              text: 'Tap',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('Disabled button does not trigger callback', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              onPressed: () => tapped = true,
              text: 'Tap',
              isDisabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      expect(tapped, isFalse);
    });

    testWidgets('Loading state shows progress indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              onPressed: () {},
              text: 'Tap',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Tap'), findsNothing);
    });
  });
}
