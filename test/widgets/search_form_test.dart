import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/pages/home_dashboard/components/search_form.dart';
import 'package:deshmukh_travelling/pages/home_dashboard/home_dashboard_model.dart';
import 'package:deshmukh_travelling/components/button/button_widget.dart';
import 'package:deshmukh_travelling/flutter_flow/flutter_flow_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:deshmukh_travelling/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('SearchForm renders correctly', (WidgetTester tester) async {
    final model = HomeDashboardModel();
    model.fromLocation = 'Mumbai';
    model.toLocation = 'Pune';
    model.selectedDate = DateTime(2023, 10, 24);
    model.passengerCount = 1;
    // Mocking button model
    model.buttonModel1 = ButtonModel();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: Scaffold(
          body: SearchForm(
            model: model,
            onSwap: () {},
            onPickLocation: (_) {},
            onPickDate: () {},
            onSearch: () {},
          ),
        ),
      ),
    );

    expect(find.text('Mumbai'), findsOneWidget);
    expect(find.text('Pune'), findsOneWidget);
    expect(find.text('Search Buses'), findsOneWidget);
  });
}
