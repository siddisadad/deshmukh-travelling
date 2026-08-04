import '/backend/firebase/firestore_service.dart';
import '/components/filter_chip/filter_chip_model.dart';
import '/components/bus_card/bus_card_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/bus_record.dart';
import 'bus_search_results_widget.dart' show BusSearchResultsWidget;
import 'package:flutter/material.dart';

class BusSearchResultsModel extends FlutterFlowModel<BusSearchResultsWidget> {
  ///  State fields for stateful widgets in this page.

  final firestoreService = FirestoreService();
  Future<List<BusRecord>>? busesFuture;
  List<BusRecord> allBuses = [];
  List<BusRecord> filteredBuses = [];

  String selectedFilter = 'All';
  String sortBy = 'Price';
  String? timeFilter; // 'Morning', 'Afternoon', 'Evening', 'Night'

  void applyFilters() {
    filteredBuses = allBuses.where((bus) {
      bool typeMatch =
          selectedFilter == 'All' || bus.type.contains(selectedFilter);

      bool timeMatch = true;
      if (timeFilter != null) {
        final hour = _parseHour(bus.depTime);
        if (timeFilter == 'Morning') {
          timeMatch = hour >= 6 && hour < 12;
        } else if (timeFilter == 'Afternoon') {
          timeMatch = hour >= 12 && hour < 17;
        } else if (timeFilter == 'Evening') {
          timeMatch = hour >= 17 && hour < 21;
        } else if (timeFilter == 'Night') {
          timeMatch = hour >= 21 || hour < 6;
        }
      }

      return typeMatch && timeMatch;
    }).toList();

    if (sortBy == 'Price') {
      filteredBuses.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'Rating') {
      filteredBuses.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (sortBy == 'Earliest') {
      filteredBuses.sort((a, b) => a.depTime.compareTo(b.depTime));
    } else if (sortBy == 'Latest') {
      filteredBuses.sort((a, b) => b.depTime.compareTo(a.depTime));
    }
  }

  int _parseHour(String timeStr) {
    // Example: "08:30 AM" or "08:30 PM"
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final isPM = parts[1] == 'PM';

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return hour;
  }

  // Model for FilterChip.
  late FilterChipModel filterChipModel1;
  // Model for FilterChip.
  late FilterChipModel filterChipModel2;
  // Model for FilterChip.
  late FilterChipModel filterChipModel3;
  // Model for FilterChip.
  late FilterChipModel filterChipModel4;
  // Model for FilterChip.
  late FilterChipModel filterChipModel5;
  // Model for FilterChip.
  late FilterChipModel filterChipModel6;
  // Model for BusCard.
  late BusCardModel busCardModel1;
  // Model for BusCard.
  late BusCardModel busCardModel2;
  // Model for BusCard.
  late BusCardModel busCardModel3;
  // Model for BusCard.
  late BusCardModel busCardModel4;

  @override
  void initState(BuildContext context) {
    filterChipModel1 = createModel(context, () => FilterChipModel());
    filterChipModel2 = createModel(context, () => FilterChipModel());
    filterChipModel3 = createModel(context, () => FilterChipModel());
    filterChipModel4 = createModel(context, () => FilterChipModel());
    filterChipModel5 = createModel(context, () => FilterChipModel());
    filterChipModel6 = createModel(context, () => FilterChipModel());
    busCardModel1 = createModel(context, () => BusCardModel());
    busCardModel2 = createModel(context, () => BusCardModel());
    busCardModel3 = createModel(context, () => BusCardModel());
    busCardModel4 = createModel(context, () => BusCardModel());
  }

  @override
  void dispose() {
    filterChipModel1.dispose();
    filterChipModel2.dispose();
    filterChipModel3.dispose();
    filterChipModel4.dispose();
    filterChipModel5.dispose();
    filterChipModel6.dispose();
    busCardModel1.dispose();
    busCardModel2.dispose();
    busCardModel3.dispose();
    busCardModel4.dispose();
  }
}
