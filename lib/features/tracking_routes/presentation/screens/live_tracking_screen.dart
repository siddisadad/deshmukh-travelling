import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/firebase_auth/auth_util.dart';
import '../../../../components/app_header.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../domain/entities/bus_location.dart';
import '../providers/tracking_providers.dart';
import 'live_chat_screen.dart';
import '../../../../l10n/app_localizations.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({
    super.key,
    this.busId,
  });

  final String? busId;

  static String routeName = 'LiveTracking';
  static String routePath = '/liveTracking';

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  google_maps.GoogleMapController? _mapController;
  final Set<google_maps.Marker> _markers = {};
  final Set<google_maps.Polyline> _polylines = {};

  static const google_maps.LatLng _initialPosition = google_maps.LatLng(19.0760, 72.8777);

  @override
  void initState() {
    super.initState();
    _polylines.add(
      google_maps.Polyline(
        polylineId: const google_maps.PolylineId('bus_path'),
        points: [
          const google_maps.LatLng(19.0760, 72.8777),
          const google_maps.LatLng(19.1000, 72.8800),
          const google_maps.LatLng(19.1200, 72.8900),
          const google_maps.LatLng(19.1500, 72.9000),
        ],
        color: const Color(0xFF4B39EF), // Primary color
        width: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final trackingAsync = ref.watch(busTrackingProvider(widget.busId ?? 'bus1'));

    return Scaffold(
      body: Column(
        children: [
          AppHeader(title: l10n.liveTracking),
          Expanded(
            child: trackingAsync.when(
              data: (location) {
                _markers.clear();
                _markers.add(
                  google_maps.Marker(
                    markerId: const google_maps.MarkerId('bus_marker'),
                    position: google_maps.LatLng(location.latitude, location.longitude),
                    infoWindow: google_maps.InfoWindow(title: location.bus.name),
                    icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
                        google_maps.BitmapDescriptor.hueAzure),
                  ),
                );

                _mapController?.animateCamera(
                  google_maps.CameraUpdate.newLatLng(
                    google_maps.LatLng(location.latitude, location.longitude),
                  ),
                );

                return Stack(
                  children: [
                    google_maps.GoogleMap(
                      initialCameraPosition: const google_maps.CameraPosition(
                        target: _initialPosition,
                        zoom: 12.0,
                      ),
                      markers: _markers,
                      polylines: _polylines,
                      onMapCreated: (controller) => _mapController = controller,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      mapToolbarEnabled: false,
                      trafficEnabled: true,
                    ),
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: FloatingActionButton.small(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        child: const Icon(Icons.my_location, color: Colors.white),
                        onPressed: () {
                          _mapController?.animateCamera(
                            google_maps.CameraUpdate.newLatLng(
                              google_maps.LatLng(location.latitude, location.longitude),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 24.0,
                      left: 24.0,
                      right: 24.0,
                      child: _buildBusInfoCard(context, location),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusInfoCard(BuildContext context, BusLocation location) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            color: Color(0x33000000),
            offset: Offset(0.0, 5.0),
          )
        ],
      ),
      padding: const EdgeInsets.all(20.0),
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
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.bus.name,
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                    Text(
                      location.busNumber,
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
                  AppLocalizations.of(context)!.onTime,
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).success,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24.0),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: FlutterFlowTheme.of(context).accent2,
                child: Icon(Icons.person, color: FlutterFlowTheme.of(context).secondaryText),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(location.driverName, style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
                    Text(AppLocalizations.of(context)!.busCaptain, style: FlutterFlowTheme.of(context).labelSmall),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.call, color: FlutterFlowTheme.of(context).success),
                onPressed: () async {
                  final Uri launchUri = Uri(scheme: 'tel', path: location.driverPhone);
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline_rounded, color: FlutterFlowTheme.of(context).primary),
                onPressed: () => context.pushNamed(LiveChatScreen.routeName),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _showSosDialog(context, ref, location.bus.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('SOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.eta, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Text('15 Mins', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.distance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Text('4.2 km', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(AppLocalizations.of(context)!.nextStop, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Text('Sion', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSosDialog(BuildContext context, WidgetRef ref, String busId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.emergencySos, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(l10n.sosConfirmMessage),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final result = await ref.read(trackingRepositoryProvider).sendSosAlert(busId, currentUserUid);

              if (context.mounted) {
                result.fold(
                  (data) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('SOS Alert Sent! Assistance is on the way.'), backgroundColor: Colors.red),
                  ),
                  (error) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to send SOS: ${error.message}'), backgroundColor: Colors.red),
                  ),
                );
              }
            },
            child: Text(l10n.sendSos, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
