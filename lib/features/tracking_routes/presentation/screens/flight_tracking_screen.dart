import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import '../../../../components/app_header.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../backend/firebase/firestore_service.dart';

class FlightTrackingScreen extends ConsumerStatefulWidget {
  const FlightTrackingScreen({
    super.key,
    this.flightId,
  });

  final String? flightId;

  static String routeName = 'FlightTracking';
  static String routePath = '/flightTracking';

  @override
  ConsumerState<FlightTrackingScreen> createState() => _FlightTrackingScreenState();
}

class _FlightTrackingScreenState extends ConsumerState<FlightTrackingScreen> {
  google_maps.GoogleMapController? _mapController;
  final Set<google_maps.Marker> _markers = {};
  static const google_maps.LatLng _initialPosition = google_maps.LatLng(19.0760, 72.8777);

  @override
  Widget build(BuildContext context) {
    // For flight tracking, I'll use a local stream for now to keep it simple,
    // or I could create another provider.
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Flight Tracking'),
          Expanded(
            child: StreamBuilder<Map<String, dynamic>>(
              stream: FirestoreService().getFlightStatusStream(widget.flightId ?? 'flight1'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final data = snapshot.data!;
                final lat = data['lat'] ?? 19.0760;
                final lng = data['lng'] ?? 72.8777;

                _markers.clear();
                _markers.add(
                  google_maps.Marker(
                    markerId: const google_maps.MarkerId('flight_marker'),
                    position: google_maps.LatLng(lat, lng),
                    icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
                        google_maps.BitmapDescriptor.hueCyan),
                    rotation: 45.0,
                  ),
                );

                _mapController?.animateCamera(
                  google_maps.CameraUpdate.newLatLng(google_maps.LatLng(lat, lng)),
                );

                return Stack(
                  children: [
                    google_maps.GoogleMap(
                      initialCameraPosition: const google_maps.CameraPosition(target: _initialPosition, zoom: 10.0),
                      markers: _markers,
                      onMapCreated: (controller) => _mapController = controller,
                      myLocationEnabled: true,
                      trafficEnabled: true,
                    ),
                    Positioned(
                      bottom: 24.0,
                      left: 24.0,
                      right: 24.0,
                      child: _buildFlightInfoCard(context, data),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightInfoCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [BoxShadow(blurRadius: 10.0, color: Color(0x33000000), offset: Offset(0.0, 5.0))],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.flight_takeoff_rounded, color: FlutterFlowTheme.of(context).primary, size: 32),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['flightNumber'] ?? 'AI-101', style: FlutterFlowTheme.of(context).titleMedium),
                    Text('Air India • Economy', style: FlutterFlowTheme.of(context).labelSmall),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(data['status'] ?? 'On Time', style: TextStyle(color: FlutterFlowTheme.of(context).success, fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ETA', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(data['eta'] ?? '45 Mins', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Gate', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(data['gate'] ?? 'T2 - G12', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Terminal', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('2', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
