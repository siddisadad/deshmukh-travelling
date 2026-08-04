import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/taxi_record.dart';
import '../../backend/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class TaxiBookingModel extends FlutterFlowModel {
  final firestoreService = FirestoreService();
  String pickupLocation = 'Your current location';
  String dropLocation = '';
  List<TaxiRecord> availableTaxis = [];
  TaxiRecord? selectedTaxi;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchTaxis() async {
    availableTaxis = await firestoreService.fetchTaxis();
  }
}
