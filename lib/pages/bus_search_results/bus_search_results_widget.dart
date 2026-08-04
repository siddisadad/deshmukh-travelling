import '/components/bus_card/bus_card_widget.dart';
import '/components/filter_chip/filter_chip_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'bus_search_results_model.dart';
export 'bus_search_results_model.dart';

class BusSearchResultsWidget extends StatefulWidget {
  const BusSearchResultsWidget({super.key});

  static String routeName = 'BusSearchResults';
  static String routePath = '/busSearchResults';

  @override
  State<BusSearchResultsWidget> createState() => _BusSearchResultsWidgetState();
}

class _BusSearchResultsWidgetState extends State<BusSearchResultsWidget> {
  late BusSearchResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusSearchResultsModel());

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
                color: FlutterFlowTheme.of(context).primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).onPrimary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.goNamed(HomeDashboardWidget.routeName);
                            },
                          ),
                          Text(
                            'Available Buses',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: FlutterFlowTheme.of(context).onPrimary,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).onPrimary10,
                          borderRadius: BorderRadius.circular(16.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mumbai → Pune',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onSurface,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                      Text(
                                        'Oct 28, 2023 • 2 Travelers',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onSurface80,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                              lineHeight: 1.6,
                                            ),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Icon(
                                  Icons.tune_rounded,
                                  color: FlutterFlowTheme.of(context).onSurface,
                                  size: 24.0,
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.filterChipModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.bus_alert_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'All',
                                    selected: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.ac_unit_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'AC',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.air_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'Non-AC',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.bed_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'Sleeper',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.airline_seat_recline_normal_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'Seater',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FilterChipWidget(
                                    icon: Icon(
                                      Icons.auto_awesome_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                    iconPresent: true,
                                    label: 'Luxury',
                                    selected: false,
                                  ),
                                ),
                              ].divide(SizedBox(width: 0.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 16.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '24 Buses found',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
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
                            'Sort by:',
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
                                  color: FlutterFlowTheme.of(context).onSurface,
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
                          Text(
                            'Price',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 14.0,
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ],
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.busCardModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: BusCardWidget(
                                  arrTime: '12:45',
                                  depTime: '08:30',
                                  duration: '4h 15m',
                                  operator: 'Deshmukh Enterprises',
                                  price: '850',
                                  rating: '4.8',
                                  seats: '12',
                                  type: 'Volvo Multi-Axle AC',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.busCardModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: BusCardWidget(
                                  arrTime: '14:00',
                                  depTime: '09:15',
                                  duration: '4h 45m',
                                  operator: 'RedBus Express',
                                  price: '720',
                                  rating: '4.5',
                                  seats: '4',
                                  type: 'Scania Luxury AC',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.busCardModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: BusCardWidget(
                                  arrTime: '14:30',
                                  depTime: '10:00',
                                  duration: '4h 30m',
                                  operator: 'Dharamshti Travels',
                                  price: '600',
                                  rating: '4.2',
                                  seats: '22',
                                  type: 'Mahindra Open-Top AC',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.busCardModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: BusCardWidget(
                                  arrTime: '06:30',
                                  depTime: '22:00',
                                  duration: '8h 30m',
                                  operator: 'Deshmukh Nightlink',
                                  price: '1,200',
                                  rating: '4.9',
                                  seats: '8',
                                  type: 'Electric Sleeper AC',
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Container(
                                    child: Container(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.network(
                                            'https://dimg.dreamflow.cloud/v1/lottie/searching+for+more+buses',
                                            width: 120.0,
                                            height: 120.0,
                                            fit: BoxFit.contain,
                                            animate: true,
                                          ),
                                          Text(
                                            'You\'ve seen all the buses for this route',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                  lineHeight: 1.6,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
