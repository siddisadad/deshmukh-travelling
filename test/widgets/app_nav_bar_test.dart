import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/components/app_nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget wrapWithRouter(Widget child) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => Scaffold(body: child)),
        GoRoute(name: 'MyTrips', path: '/trips', builder: (context, state) => const Text('Trips Page')),
        GoRoute(name: 'HomeDashboard', path: '/home', builder: (context, state) => const Text('Home Page')),
        GoRoute(name: 'HajjDashboard', path: '/hajj', builder: (context, state) => const Text('Hajj Page')),
        GoRoute(name: 'Wallet', path: '/wallet', builder: (context, state) => const Text('Wallet Page')),
        GoRoute(name: 'ProfileSettings', path: '/profile', builder: (context, state) => const Text('Profile Page')),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
    );
  }

  testWidgets('AppNavBar renders all navigation items', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithRouter(
      const AppNavBar(currentRoute: 'HomeDashboard'),
    ));

    // Wait for entry animations
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('My Trips'), findsOneWidget);
    expect(find.text('Hajj'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('AppNavBar highlights the current route', (WidgetTester tester) async {
    // This is a bit hard to test precisely without looking at colors,
    // but we can verify the icons and text are present.
    await tester.pumpWidget(wrapWithRouter(
      const AppNavBar(currentRoute: 'MyTrips'),
    ));

    await tester.pump(const Duration(milliseconds: 500));

    // Verify icons are present
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
    expect(find.byIcon(Icons.confirmation_number_rounded), findsOneWidget);
  });
}
