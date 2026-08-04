import 'components/bus_seat_map.dart';
import '/components/button/button_widget.dart';
import '/components/seat_legend_item/seat_legend_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_selection_model.dart';
export 'seat_selection_model.dart';

class SeatSelectionWidget extends StatefulWidget {
  const SeatSelectionWidget({
    super.key,
    this.bus,
  });

  final BusRecord? bus;

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
    _model.pricePerSeat = widget.bus?.price ?? 1250.0;

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
                padding: EdgeInsets.symmetric(
                  horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg,
                  vertical: FlutterFlowTheme.of(context).designToken.spacing.md,
                ),
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
                          context.safePop();
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
                              AppLocalizations.of(context)!.selectSeats,
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
                              '${widget.bus?.departureCity.split(',').first ?? 'Mumbai'} → ${widget.bus?.arrivalCity.split(',').first ?? 'Pune'} • ${AppLocalizations.of(context)!.availableBuses}',
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
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
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
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
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
                                                BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.sm),
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
                                                widget.bus?.name ?? 'Deshmukh Premium AC',
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
                                                    widget.bus?.type ?? 'Volvo B11R',
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
                              BusSeatMap(
                                model: _model,
                                onToggleSeat: (number) {
                                  setState(() {
                                    _model.toggleSeat(number);
                                  });
                                },
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
                                '₹${_model.totalPrice.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
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
                                    '${_model.selectedSeatNumbers.length} Seats',
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
                                context.goNamed(
                                  PassengerDetailsWidget.routeName,
                                  queryParameters: {
                                    'selectedSeats': serializeParam(
                                      _model.selectedSeatNumbers,
                                      ParamType.String,
                                      isList: true,
                                    ),
                                    'bus': serializeParam(
                                      widget.bus,
                                      ParamType.JSON,
                                    ),
                                  }.withoutNulls,
                                );
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
                                  content: AppLocalizations.of(context)!.continueBtn,
                                  variant: 'primary',
                                  size: 'large',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: _model.selectedSeatNumbers.isEmpty,
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
