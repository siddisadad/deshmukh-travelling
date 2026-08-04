import '/components/button/button_widget.dart';
import '/components/seat_legend_item/seat_legend_item_widget.dart';
import '/components/seat_widget/seat_widget_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_selection_model.dart';
export 'seat_selection_model.dart';

class SeatSelectionWidget extends StatefulWidget {
  const SeatSelectionWidget({super.key});

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
        body: Column(
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
                        onPressed: () {
                          print('IconButton pressed ...');
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.45,
                                  ),
                            ),
                            Text(
                              'Mumbai → Pune • 24 Oct',
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.info_outlined,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.directions_bus_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimaryContainer,
                                            size: 24.0,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Deshmukh Premium AC',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.5,
                                                        ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Gat 2041',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                          lineHeight: 1.4,
                                                        ),
                                                  ),
                                                  Container(
                                                    width: 4.0,
                                                    height: 4.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent3,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Volvo B11R',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                          lineHeight: 1.4,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .onSurface,
                                                  size: 14.0,
                                                ),
                                                Text(
                                                  '4.8',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 2.0)),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      label: 'Available',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .surfaceVariant,
                                      label: 'Booked',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.seatLegendItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SeatLegendItemWidget(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      label: 'Selected',
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(24.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                  bottomLeft:
                                                      Radius.circular(16.0),
                                                  bottomRight:
                                                      Radius.circular(4.0),
                                                ),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel1,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '1',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel2,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '2',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel3,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '3',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel4,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '4',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel5,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '5',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel6,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '6',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel7,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '7',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel8,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '8',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                  bottomLeft:
                                                      Radius.circular(4.0),
                                                  bottomRight:
                                                      Radius.circular(16.0),
                                                ),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Icon(
                                                Icons.wc_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .onSurface,
                                                size: 16.0,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel9,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '9',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel10,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '10',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel11,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '11',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel12,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '12',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel13,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '13',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel14,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '14',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel15,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '15',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel16,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '16',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                  bottomLeft:
                                                      Radius.circular(16.0),
                                                  bottomRight:
                                                      Radius.circular(4.0),
                                                ),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel17,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '17',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel18,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '18',
                                                          status: 'selected',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel19,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '19',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel20,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '20',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel21,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '21',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel22,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '22',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12.0,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel23,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '23',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                      wrapWithModel(
                                                        model: _model
                                                            .seatWidgetModel24,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: SeatWidgetWidget(
                                                          number: '24',
                                                          status: 'booked',
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 32.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹1,250',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '2 Seats',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Text(
                                    '(Incl. taxes)',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .onSurface,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ],
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context
                                    .goNamed(PassengerDetailsWidget.routeName);
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  iconPresent: true,
                                  iconEndPresent: false,
                                  content: 'Continue',
                                  variant: 'primary',
                                  size: 'large',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 24.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
