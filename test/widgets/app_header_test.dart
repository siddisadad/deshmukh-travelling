import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/components/app_header.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    // Prevent Google Fonts from attempting to fetch fonts during tests
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  testWidgets('AppHeader renders title and default back button', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithTheme(
      const AppHeader(title: 'Test Header'),
    ));

    // Wait for entry animations
    await tester.pumpAndSettle();

    expect(find.text('Test Header'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });

  testWidgets('AppHeader hides back button when showBackButton is false', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithTheme(
      const AppHeader(title: 'No Back Button', showBackButton: false),
    ));

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_back_rounded), findsNothing);
  });

  testWidgets('AppHeader renders action widget when provided', (WidgetTester tester) async {
    const actionKey = Key('action-button');
    await tester.pumpWidget(wrapWithTheme(
      const AppHeader(
        title: 'Action Header',
        actionWidget: Icon(Icons.settings, key: actionKey),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byKey(actionKey), findsOneWidget);
  });

  testWidgets('AppHeader renders bottom widget when provided', (WidgetTester tester) async {
    const bottomKey = Key('bottom-widget');
    await tester.pumpWidget(wrapWithTheme(
      const AppHeader(
        title: 'Bottom Header',
        bottom: SizedBox(height: 50, key: bottomKey),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byKey(bottomKey), findsOneWidget);
  });
}
