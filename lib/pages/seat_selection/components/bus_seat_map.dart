import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/seat_widget/seat_widget_widget.dart';
import '../seat_selection_model.dart';

class BusSeatMap extends StatelessWidget {
  final SeatSelectionModel model;
  final Function(String) onToggleSeat;

  const BusSeatMap({
    super.key,
    required this.model,
    required this.onToggleSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            // Dynamic seat rows
            for (int i = 0; i < 6; i++)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left icon/container (steering/toilet etc)
                  Container(
                    width: 80.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: i == 1
                        ? Icon(Icons.wc_rounded,
                            color: FlutterFlowTheme.of(context).onSurface,
                            size: 16.0)
                        : (i == 0 || i == 4
                            ? Icon(Icons.radio_button_checked_rounded,
                                color: FlutterFlowTheme.of(context).onSurface,
                                size: 16.0)
                            : null),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int row = 0; row < 2; row++)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int col = 0; col < 4; col++)
                                if (col == 2)
                                  const SizedBox(width: 12.0)
                                else
                                  Builder(
                                    builder: (context) {
                                      final seatIndex = (i * 4) +
                                          (row * 2) +
                                          (col > 2 ? col - 1 : col);
                                      if (seatIndex >= model.seats.length) {
                                        return const SizedBox(width: 32.0, height: 32.0);
                                      }
                                      final seat = model.seats[seatIndex];
                                      return InkWell(
                                        onTap: () => onToggleSeat(seat.number),
                                        child: SeatWidgetWidget(
                                          number: seat.number,
                                          status: seat.status,
                                        ),
                                      );
                                    },
                                  )
                            ].divide(const SizedBox(width: 16.0)),
                          )
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                  ),
                ].divide(const SizedBox(width: 16.0)),
              ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    ),
    );
  }
}
