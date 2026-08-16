import '/components/button/button_widget.dart';
import '/components/seat_legend_item/seat_legend_item_widget.dart';
import '/components/seat_widget/seat_widget_widget.dart';
import '/backend/schema/buses_record.dart';
import '/backend/schema/seats_record.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_selection_model.dart';
export 'seat_selection_model.dart';

class SeatSelectionWidget extends StatefulWidget {
  const SeatSelectionWidget({
    super.key,
    this.busRef,
  });

  final DocumentReference? busRef;

  static String routeName = 'SeatSelection';
  static String routePath = '/seatSelection';

  @override
  State<SeatSelectionWidget> createState() => _SeatSelectionWidgetState();
}

class _SeatSelectionWidgetState extends State<SeatSelectionWidget> {
  late SeatSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeatSelectionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: StreamBuilder<BusesRecord>(
          stream: BusesRecord.streamForRef(widget.busRef),
          builder: (context, busSnapshot) {
            if (!busSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final bus = busSnapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.goNamed(BusSearchResultsWidget.routeName);
                            },
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Seats',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        lineHeight: 1.45,
                                      ),
                                ),
                                Text(
                                  '${bus.operator} • ${bus.type}',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(24.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Top part: Steering wheel
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 48.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.radio_button_checked_rounded,
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              size: 32.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 32.0),
                                      // Seat Grid
                                      StreamBuilder<List<SeatsRecord>>(
                                        stream:
                                            SeatsRecord.getStream(widget.busRef),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                          final seats = snapshot.data!;
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (int i = 0; i < seats.length; i += 4)
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 16.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      // Left 2 seats
                                                      for (int j = 0; j < 2 && (i + j) < seats.length; j++)
                                                        Padding(
                                                          padding: EdgeInsets.only(right: 12.0),
                                                          child: InkWell(
                                                            onTap: seats[i+j].status == 'available' ? () {
                                                              safeSetState(() {
                                                                _model.toggleSeat(seats[i+j].number);
                                                              });
                                                            } : null,
                                                            child: SeatWidgetWidget(
                                                              number: seats[i + j].number,
                                                              status: _model.selectedSeatNumbers.contains(seats[i+j].number) ? 'selected' : seats[i+j].status,
                                                            ),
                                                          ),
                                                        ),
                                                      // Aisle
                                                      SizedBox(width: 24.0),
                                                      // Right 2 seats
                                                      for (int j = 2; j < 4 && (i + j) < seats.length; j++)
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 12.0),
                                                          child: InkWell(
                                                            onTap: seats[i+j].status == 'available' ? () {
                                                              safeSetState(() {
                                                                _model.toggleSeat(seats[i+j].number);
                                                              });
                                                            } : null,
                                                            child: SeatWidgetWidget(
                                                              number: seats[i + j].number,
                                                              status: _model.selectedSeatNumbers.contains(seats[i+j].number) ? 'selected' : seats[i+j].status,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.0),
                              // Legend
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                      label: 'Available',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color: FlutterFlowTheme.of(context).surfaceVariant,
                                      label: 'Booked',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color: FlutterFlowTheme.of(context).primary,
                                      label: 'Selected',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom Bar
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    border: Border(top: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹${formatNumber(bus.price * _model.selectedSeatNumbers.length, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${_model.selectedSeatNumbers.length} Seats Selected',
                              style: FlutterFlowTheme.of(context).labelSmall,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: _model.selectedSeatNumbers.isNotEmpty ? () async {
                            context.goNamed(
                              PassengerDetailsWidget.routeName,
                              queryParameters: {
                                'selectedSeats': serializeParam(
                                  _model.selectedSeatNumbers,
                                  ParamType.String,
                                  true,
                                ),
                                'busRef': serializeParam(
                                  widget.busRef,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          } : null,
                          child: wrapWithModel(
                            model: _model.buttonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'Continue',
                              variant: 'primary',
                              size: 'large',
                              disabled: _model.selectedSeatNumbers.isEmpty,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
