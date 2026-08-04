import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/room_record.dart';
import '../../backend/firebase/firestore_service.dart';
import 'hotel_details_widget.dart' show HotelDetailsWidget;
import 'package:flutter/material.dart';

class HotelDetailsModel extends FlutterFlowModel<HotelDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final firestoreService = FirestoreService();
  List<RoomRecord> rooms = [];
  bool isLoading = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchRooms(String hotelId) async {
    isLoading = true;
    rooms = await firestoreService.fetchRooms(hotelId);
    isLoading = false;
  }
}
