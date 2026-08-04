import '/components/tab_item/tab_item_widget.dart';
import '/components/trip_card/trip_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_trips_model.dart';
export 'my_trips_model.dart';

class MyTripsWidget extends StatefulWidget {
  const MyTripsWidget({super.key});

  static String routeName = 'MyTrips';
  static String routePath = '/myTrips';

  @override
  State<MyTripsWidget> createState() => _MyTripsWidgetState();
}

class _MyTripsWidgetState extends State<MyTripsWidget> {
  late MyTripsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyTripsModel());

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                    child: Container(
                      child: Row(
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
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Text(
                            'My Trips',
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
                                      FlutterFlowTheme.of(context).primaryText,
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
                              Icons.filter_list_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: wrapWithModel(
                      model: _model.tabItemModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: TabItemWidget(
                        label: 'Upcoming',
                        active: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: wrapWithModel(
                      model: _model.tabItemModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: TabItemWidget(
                        label: 'Completed',
                        active: false,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: wrapWithModel(
                      model: _model.tabItemModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: TabItemWidget(
                        label: 'Cancelled',
                        active: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upcoming Journeys',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.45,
                                        ),
                                  ),
                                  Text(
                                    '2 Trips',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            wrapWithModel(
                              model: _model.tripCardModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TripCardWidget(
                                arrCity: 'Pune',
                                arrTime: '06:00 AM',
                                busType: 'AC • Sleeper',
                                date: '24 Oct, 2023',
                                depCity: 'Mumbai',
                                depTime: '08:30 PM',
                                duration: '9h 30m',
                                operator: 'Deshmukh Luxury',
                                price: '₹1,250',
                                seats: 'S-12, S-13',
                                status: 'upcoming',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.tripCardModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: TripCardWidget(
                                arrCity: 'Satara',
                                arrTime: '02:30 PM',
                                busType: 'Non-AC • Seater',
                                date: '28 Oct, 2023',
                                depCity: 'Pune',
                                depTime: '10:00 AM',
                                duration: '4h 30m',
                                operator: 'Vikas Travels',
                                price: '₹450',
                                seats: 'B-04',
                                status: 'upcoming',
                              ),
                            ),
                            Container(
                              height: 24.0,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Container(
                                child: Text(
                                  'Recent History',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.45,
                                      ),
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.tripCardModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: TripCardWidget(
                                arrCity: 'Thane',
                                arrTime: '04:00 AM',
                                busType: 'AC • Coacher',
                                date: '15 Oct, 2023',
                                depCity: 'Mumbai',
                                depTime: '09:00 PM',
                                duration: '7h 00m',
                                operator: 'Deshmukh Enterprise',
                                price: '₹800',
                                seats: 'C-21',
                                status: 'completed',
                              ),
                            ),
                          ].divide(SizedBox(height: 0.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
