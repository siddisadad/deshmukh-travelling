import '/components/button/button_widget.dart';
import '/components/seat_legend_item/seat_legend_item_widget.dart';
import '/components/seat_widget/seat_widget_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'seat_selection_widget.dart' show SeatSelectionWidget;
import 'package:flutter/material.dart';

class Seat {
  final String number;
  final String status; // 'available', 'booked', 'selected'
  final double price;

  Seat({
    required this.number,
    required this.status,
    required this.price,
  });

  Seat copyWith({String? status}) {
    return Seat(
      number: this.number,
      status: status ?? this.status,
      price: this.price,
    );
  }
}

class SeatSelectionModel extends FlutterFlowModel<SeatSelectionWidget> {
  ///  State fields for stateful widgets in this page.

  List<Seat> seats = [];
  List<String> selectedSeatNumbers = [];
  double pricePerSeat = 1250.0;

  double get totalPrice => selectedSeatNumbers.length * pricePerSeat;

  void toggleSeat(String number) {
    if (selectedSeatNumbers.contains(number)) {
      selectedSeatNumbers.remove(number);
      // Update seat status in list
      final index = seats.indexWhere((s) => s.number == number);
      if (index != -1) {
        seats[index] = seats[index].copyWith(status: 'available');
      }
    } else {
      selectedSeatNumbers.add(number);
      final index = seats.indexWhere((s) => s.number == number);
      if (index != -1) {
        seats[index] = seats[index].copyWith(status: 'selected');
      }
    }
  }

  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel1;
  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel2;
  // Model for SeatLegendItem.
  late SeatLegendItemModel seatLegendItemModel3;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel1;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel2;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel3;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel4;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel5;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel6;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel7;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel8;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel9;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel10;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel11;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel12;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel13;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel14;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel15;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel16;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel17;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel18;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel19;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel20;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel21;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel22;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel23;
  // Model for SeatWidget.
  late SeatWidgetModel seatWidgetModel24;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    seatLegendItemModel1 = createModel(context, () => SeatLegendItemModel());
    seatLegendItemModel2 = createModel(context, () => SeatLegendItemModel());
    seatLegendItemModel3 = createModel(context, () => SeatLegendItemModel());

    // Initialize mock seats
    seats = List.generate(24, (index) {
      final number = (index + 1).toString();
      // Make some seats booked for demo
      final status = (index % 5 == 0) ? 'booked' : 'available';
      return Seat(number: number, status: status, price: 1250.0);
    });

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
