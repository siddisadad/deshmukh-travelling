import '/backend/schema/buses_record.dart';
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
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 54.0, 24.0, 24.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ),
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
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
                              safeSetState(() {});
                            },
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
            // Filter Bar
            Container(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (var filter in ['All', 'AC', 'Non-AC', 'Sleeper', 'Seater', 'Luxury'])
                              InkWell(
                                onTap: () => safeSetState(() => _model.selectedFilter = filter),
                                child: FilterChipWidget(
                                  label: filter,
                                  selected: _model.selectedFilter == filter,
                                  iconPresent: false,
                                ),
                              ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Main List with dynamic count
            Expanded(
              child: StreamBuilder<List<BusesRecord>>(
                stream: BusesRecord.getStream(filter: _model.selectedFilter),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    final buses = BusesRecord.demoBuses(
                      filter: _model.selectedFilter,
                    );
                    return _buildBusList(context, buses);
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    );
                  }
                  final buses = snapshot.data!;
                  return _buildBusList(context, buses);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusList(BuildContext context, List<BusesRecord> buses) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${buses.length} Buses found',
                style: FlutterFlowTheme.of(context).labelLarge,
              ),
              Row(
                children: [
                  Text('Sort by:',
                      style: FlutterFlowTheme.of(context).labelSmall),
                  Text(
                    'Price',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                          color: FlutterFlowTheme.of(context).primary,
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
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                if (buses.isEmpty)
                  Center(child: Text('No buses found for this filter'))
                else
                  ...buses.map(
                    (bus) => BusCardWidget(
                      operator: bus.operator,
                      type: bus.type,
                      depTime: bus.depTime,
                      arrTime: bus.arrTime,
                      duration: bus.duration,
                      price: bus.price.toString(),
                      rating: bus.rating.toString(),
                      seats: bus.seatsAvailable.toString(),
                      busRef: bus.reference,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Lottie.network(
                        'https://dimg.dreamflow.cloud/v1/lottie/searching+for+more+buses',
                        width: 120.0,
                        height: 120.0,
                      ),
                      Text(
                        'You\'ve seen all the buses for this route',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ],
    );
  }
}
