import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/booking_record.dart';
import '/components/tab_item/tab_item_widget.dart';
import '/components/trip_card/trip_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
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

    _model.bookingsFuture = _model.firestoreService.fetchUserBookings(currentUserUid);

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
                              context.safePop();
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.myTrips,
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
                    child: InkWell(
                      onTap: () => setState(() => _model.selectedTab = 'Upcoming'),
                      child: wrapWithModel(
                        model: _model.tabItemModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: TabItemWidget(
                          label: 'Upcoming',
                          active: _model.selectedTab == 'Upcoming',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => setState(() => _model.selectedTab = 'Completed'),
                      child: wrapWithModel(
                        model: _model.tabItemModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: TabItemWidget(
                          label: 'Completed',
                          active: _model.selectedTab == 'Completed',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => setState(() => _model.selectedTab = 'Cancelled'),
                      child: wrapWithModel(
                        model: _model.tabItemModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: TabItemWidget(
                          label: 'Cancelled',
                          active: _model.selectedTab == 'Cancelled',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<BookingRecord>>(
                future: _model.bookingsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('Error loading trips'));
                  }

                  final allTrips = snapshot.data!;
                  final filteredTrips = allTrips.where((t) {
                    if (_model.selectedTab == 'Upcoming') {
                      return t.status == 'upcoming' || t.timestamp.isAfter(DateTime.now());
                    } else if (_model.selectedTab == 'Completed') {
                      return t.status == 'completed' || (t.status != 'cancelled' && t.timestamp.isBefore(DateTime.now()));
                    } else {
                      return t.status == 'cancelled';
                    }
                  }).toList();

                  return SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (filteredTrips.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${_model.selectedTab} Journeys',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                      ),
                                      Text(
                                        '${filteredTrips.length} Trips',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              font: GoogleFonts.inter(),
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (var trip in filteredTrips)
                                  TripCardWidget(
                                    key: Key(trip.id ?? ''),
                                    bookingId: trip.id,
                                    arrCity: trip.arrivalCity.split(',').first,
                                    arrTime: trip.arrTime,
                                    busType: trip.busType,
                                    date: dateTimeFormat(
                                        'd MMM, y', trip.timestamp),
                                    depCity: trip.departureCity.split(',').first,
                                    depTime: trip.depTime,
                                    duration: '9h 30m',
                                    operator: trip.busName,
                                    price: '₹${trip.totalAmount.toInt()}',
                                    seats: trip.seatNumbers.join(', '),
                                    status: trip.status,
                                    onCancel: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Cancel Booking'),
                                          content: const Text('Are you sure you want to cancel this booking? The full amount will be refunded to your wallet.'),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
                                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes, Cancel')),
                                          ],
                                        ),
                                      );
                                      if (confirm == true) {
                                        await _model.firestoreService.cancelBookingWithRefund(trip);
                                        setState(() {
                                          _model.bookingsFuture = _model.firestoreService.fetchUserBookings(currentUserUid);
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Booking cancelled and refund processed!')),
                                        );
                                      }
                                    },
                                  ),
                              ] else
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Text(
                                        'No ${_model.selectedTab.toLowerCase()} trips found.'),
                                  ),
                                ),
                            ].divide(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
