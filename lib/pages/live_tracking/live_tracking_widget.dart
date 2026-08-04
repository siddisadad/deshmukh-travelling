import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart' hide LatLng;
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'live_tracking_model.dart';
export 'live_tracking_model.dart';

class LiveTrackingWidget extends StatefulWidget {
  const LiveTrackingWidget({
    super.key,
    this.busId,
  });

  final String? busId;

  static String routeName = 'LiveTracking';
  static String routePath = '/liveTracking';

  @override
  State<LiveTrackingWidget> createState() => _LiveTrackingWidgetState();
}

class _LiveTrackingWidgetState extends State<LiveTrackingWidget> {
  late LiveTrackingModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Mock initial position for Mumbai
  static const google_maps.LatLng _initialPosition = google_maps.LatLng(19.0760, 72.8777);

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LiveTrackingModel());

    // Add mock bus marker
    _model.markers.add(
      google_maps.Marker(
        markerId: const google_maps.MarkerId('bus_marker'),
        position: google_maps.LatLng(_model.currentLat, _model.currentLng),
        infoWindow: const google_maps.InfoWindow(title: 'Deshmukh Luxury'),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueBlue),
      ),
    );

    // Add mock path
    _model.polylines.add(
      google_maps.Polyline(
        polylineId: const google_maps.PolylineId('bus_path'),
        points: [
          const google_maps.LatLng(19.0760, 72.8777),
          const google_maps.LatLng(19.1000, 72.8800),
          const google_maps.LatLng(19.1200, 72.8900),
          const google_maps.LatLng(19.1500, 72.9000),
        ],
        color: FlutterFlowTheme.of(context).primary,
        width: 4,
      ),
    );

    // Start Real-time Tracking
    _model.locationSubscription = _model.firestoreService
        .getBusLocationStream(widget.busId ?? 'bus1')
        .listen((coords) {
      if (!mounted) return;
      setState(() {
        _model.currentLat = coords['lat']!;
        _model.currentLng = coords['lng']!;
        _model.markers.clear();
        _model.markers.add(
          google_maps.Marker(
            markerId: const google_maps.MarkerId('bus_marker'),
            position: google_maps.LatLng(_model.currentLat, _model.currentLng),
            infoWindow: const google_maps.InfoWindow(title: 'Deshmukh Luxury'),
            icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue),
          ),
        );
      });

      _model.googleMapController?.animateCamera(
        google_maps.CameraUpdate.newLatLng(
          google_maps.LatLng(_model.currentLat, _model.currentLng),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Live Tracking',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22.0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: Stack(
        children: [
          google_maps.GoogleMap(
            initialCameraPosition: const google_maps.CameraPosition(
              target: _initialPosition,
              zoom: 12.0,
            ),
            markers: _model.markers,
            polylines: _model.polylines,
            onMapCreated: (controller) =>
                _model.googleMapController = controller,
            myLocationEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: FloatingActionButton.small(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              child: const Icon(Icons.my_location, color: Colors.white),
              onPressed: () {
                _model.googleMapController?.animateCamera(
                  google_maps.CameraUpdate.newLatLng(
                    google_maps.LatLng(_model.currentLat, _model.currentLng),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 24.0,
            left: 24.0,
            right: 24.0,
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 5.0),
                  )
                ],
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary10,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(
                          Icons.directions_bus_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deshmukh Luxury',
                              style: FlutterFlowTheme.of(context).titleMedium,
                            ),
                            Text(
                              'MH-12-AS-1234',
                              style: FlutterFlowTheme.of(context).labelSmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'On Time',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).success,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ETA',
                              style: FlutterFlowTheme.of(context).labelSmall),
                          Text(_model.eta,
                              style: FlutterFlowTheme.of(context).titleSmall),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Distance',
                              style: FlutterFlowTheme.of(context).labelSmall),
                          Text(_model.distance,
                              style: FlutterFlowTheme.of(context).titleSmall),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Next Stop', style: FlutterFlowTheme.of(context).labelSmall),
                          Text('Sion', style: FlutterFlowTheme.of(context).titleSmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
