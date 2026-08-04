import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/firebase/firestore_service.dart';
import 'live_tracking_widget.dart' show LiveTrackingWidget;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class LiveTrackingModel extends FlutterFlowModel<LiveTrackingWidget> {
  ///  State fields for stateful widgets in this page.
  final firestoreService = FirestoreService();
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  StreamSubscription<Map<String, double>>? locationSubscription;
  double currentLat = 19.1000;
  double currentLng = 72.8800;
  String eta = '15 Mins';
  String distance = '4.2 km';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    locationSubscription?.cancel();
  }
}
