import 'package:flutter_test/flutter_test.dart';

import 'package:deshmukh_travelling/pages/bus_search_results/bus_search_results_widget.dart';
import 'package:deshmukh_travelling/pages/home_dashboard/home_dashboard_widget.dart';

void main() {
  test('core booking routes are defined', () {
    expect(HomeDashboardWidget.routeName, 'HomeDashboard');
    expect(BusSearchResultsWidget.routeName, 'BusSearchResults');
  });
}
