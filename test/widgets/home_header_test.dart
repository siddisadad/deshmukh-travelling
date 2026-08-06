import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/components/home_header.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  testWidgets('HomeHeader renders title, subtitle and child', (WidgetTester tester) async {
    bool notificationTapped = false;

    await tester.pumpWidget(wrapWithTheme(
      HomeHeader(
        appTitle: 'Deshmukh Travel',
        subtitle: 'The best way to travel',
        onNotificationTap: () => notificationTapped = true,
        child: const Text('Flexible Child Content'),
      ),
    ));

    // Wait for animations to finish
    await tester.pumpAndSettle();

    expect(find.text('Deshmukh Travel'), findsOneWidget);
    expect(find.text('The best way to travel'), findsOneWidget);
    expect(find.text('Flexible Child Content'), findsOneWidget);

    // Test notification tap
    await tester.tap(find.byIcon(Icons.notifications_none_rounded));
    expect(notificationTapped, isTrue);
  });
}
