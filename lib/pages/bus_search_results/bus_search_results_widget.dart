import '/backend/schema/bus_record.dart';
import 'package:shimmer/shimmer.dart';
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
  const BusSearchResultsWidget({
    super.key,
    this.fromLocation,
    this.toLocation,
    this.date,
  });

  final String? fromLocation;
  final String? toLocation;
  final DateTime? date;

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

    _model.busesFuture = _model.firestoreService.fetchBuses(
      widget.fromLocation ?? 'Mumbai, Maharashtra',
      widget.toLocation ?? 'Pune, Maharashtra',
    );

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
                  bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                  bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg,
                  vertical: FlutterFlowTheme.of(context).designToken.spacing.md,
                ),
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
                            AppLocalizations.of(context)!.availableBuses,
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
                          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
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
                                        '${widget.fromLocation?.split(',').first ?? 'Mumbai'} → ${widget.toLocation?.split(',').first ?? 'Pune'}',
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
                                        '${dateTimeFormat('MMM d, y', widget.date ?? DateTime.now())} • 1 Traveler',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            for (var time in [
                              'Morning',
                              'Afternoon',
                              'Evening',
                              'Night'
                            ])
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(time),
                                  selected: _model.timeFilter == time,
                                  onSelected: (val) {
                                    setState(() {
                                      _model.timeFilter = val ? time : null;
                                      _model.applyFilters();
                                    });
                                  },
                                  selectedColor:
                                      FlutterFlowTheme.of(context).primary,
                                  labelStyle: TextStyle(
                                    color: _model.timeFilter == time
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'All';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.bus_alert_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'All',
                                      selected: _model.selectedFilter == 'All',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'AC';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.ac_unit_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'AC',
                                      selected: _model.selectedFilter == 'AC',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'Non-AC';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.air_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'Non-AC',
                                      selected: _model.selectedFilter == 'Non-AC',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'Sleeper';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.bed_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'Sleeper',
                                      selected: _model.selectedFilter == 'Sleeper',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'Seater';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.airline_seat_recline_normal_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'Seater',
                                      selected: _model.selectedFilter == 'Seater',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.filterChipModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _model.selectedFilter = 'Luxury';
                                        _model.applyFilters();
                                      });
                                    },
                                    child: FilterChipWidget(
                                      icon: Icon(
                                        Icons.auto_awesome_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      label: 'Luxury',
                                      selected: _model.selectedFilter == 'Luxury',
                                    ),
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
              padding: EdgeInsetsDirectional.fromSTEB(
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  0.0,
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  FlutterFlowTheme.of(context).designToken.spacing.md),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.busesFound(_model.filteredBuses.length),
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
                      InkWell(
                        onTap: () async {
                          final selectedSort = await showModalBottomSheet<String>(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(title: const Text('Cheapest First'), onTap: () => Navigator.pop(context, 'Price')),
                                ListTile(title: const Text('Highest Rated'), onTap: () => Navigator.pop(context, 'Rating')),
                                ListTile(title: const Text('Earliest Departure'), onTap: () => Navigator.pop(context, 'Earliest')),
                                ListTile(title: const Text('Latest Departure'), onTap: () => Navigator.pop(context, 'Latest')),
                              ],
                            ),
                          );
                          if (selectedSort != null) {
                            setState(() {
                              _model.sortBy = selectedSort;
                              _model.applyFilters();
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.sortBy}:',
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
                              _model.sortBy,
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
                              Icons.swap_vert_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 14.0,
                            ),
                          ].divide(const SizedBox(width: 4.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: FutureBuilder<List<BusRecord>>(
                  future: _model.busesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Shimmer.fromColors(
                          baseColor: FlutterFlowTheme.of(context).alternate,
                          highlightColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          child: Column(
                            children: List.generate(
                                3,
                                (i) => Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 180.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(child: Text('Error loading buses'));
                    }

                    if (_model.allBuses.isEmpty) {
                      _model.allBuses = snapshot.data!;
                      _model.applyFilters();
                    }

                    final buses = _model.filteredBuses;

                    return SingleChildScrollView(
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
                                  for (var bus in buses)
                                    BusCardWidget(
                                      key: Key(bus.id),
                                      bus: bus,
                                      arrTime: bus.arrTime,
                                      depTime: bus.depTime,
                                      duration: '4h 15m', // Calculate if needed
                                      operator: bus.name,
                                      price: bus.price.toInt().toString(),
                                      rating: bus.rating,
                                      seats: bus.seatsAvailable,
                                      type: bus.type,
                                    ),
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(32.0),
                                      child: Container(
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
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
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .inter(
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
                                                          color:
                                                              FlutterFlowTheme.of(
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
