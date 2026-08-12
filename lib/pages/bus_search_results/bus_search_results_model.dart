import '/components/bus_card/bus_card_widget.dart';
import '/components/filter_chip/filter_chip_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'bus_search_results_widget.dart' show BusSearchResultsWidget;
import 'package:flutter/material.dart';

class BusSearchResultsModel extends FlutterFlowModel<BusSearchResultsWidget> {
  ///  State fields for stateful widgets in this page.

  String selectedFilter = 'All';

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
