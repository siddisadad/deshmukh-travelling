import 'package:flutter_test/flutter_test.dart';

import 'package:deshmukh_travelling/backend/schema/buses_record.dart';
import 'package:deshmukh_travelling/pages/bus_search_results/bus_search_results_widget.dart';
import 'package:deshmukh_travelling/pages/home_dashboard/home_dashboard_widget.dart';

void main() {
  test('core booking routes are defined', () {
    expect(HomeDashboardWidget.routeName, 'HomeDashboard');
    expect(BusSearchResultsWidget.routeName, 'BusSearchResults');
  });

  test('demo buses filter by type string', () {
    final all = BusesRecord.demoBuses();
    expect(all, isNotEmpty);

    final ac = BusesRecord.demoBuses(filter: 'AC');
    expect(ac.every((bus) => bus.type.toLowerCase().contains('ac')), isTrue);

    final sleeper = BusesRecord.demoBuses(filter: 'Sleeper');
    expect(sleeper, isNotEmpty);
    expect(
      sleeper.every((bus) => bus.type.toLowerCase().contains('sleeper')),
      isTrue,
    );
  });
}
