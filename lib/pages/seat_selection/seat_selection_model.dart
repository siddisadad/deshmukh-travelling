import '/components/button/button_widget.dart';
import '/components/seat_legend_item/seat_legend_item_widget.dart';
import '/components/seat_widget/seat_widget_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'seat_selection_widget.dart' show SeatSelectionWidget;
import 'package:flutter/material.dart';

class SeatSelectionModel extends FlutterFlowModel<SeatSelectionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel1;
  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel2;
  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel3;
  // State for selected seats.
  List<String> selectedSeatNumbers = [];

  void toggleSeat(String number) {
    if (selectedSeatNumbers.contains(number)) {
      selectedSeatNumbers.remove(number);
    } else {
      selectedSeatNumbers.add(number);
    }
  }

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    seatLegendItemModel1 = createModel(context, () => SeatLegendItemModel());
    seatLegendItemModel2 = createModel(context, () => SeatLegendItemModel());
    seatLegendItemModel3 = createModel(context, () => SeatLegendItemModel());

    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    seatLegendItemModel1.dispose();
    seatLegendItemModel2.dispose();
    seatLegendItemModel3.dispose();
    buttonModel.dispose();
  }
}
