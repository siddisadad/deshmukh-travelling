import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/hotel_record.dart';
import '../../backend/firebase/firestore_service.dart';
import 'hotel_search_results_widget.dart' show HotelSearchResultsWidget;
import 'package:flutter/material.dart';

class HotelSearchResultsModel extends FlutterFlowModel<HotelSearchResultsWidget> {
  ///  State fields for stateful widgets in this page.

  final firestoreService = FirestoreService();
  List<HotelRecord> hotels = [];
  bool isLoading = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchHotels(String city) async {
    isLoading = true;
    hotels = await firestoreService.fetchHotels(city);
    isLoading = false;
  }
}
