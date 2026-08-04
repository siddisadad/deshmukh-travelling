import '/backend/firebase/firestore_service.dart';
import '/backend/schema/booking_record.dart';
import '/components/tab_item/tab_item_widget.dart';
import '/components/trip_card/trip_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_trips_widget.dart' show MyTripsWidget;
import 'package:flutter/material.dart';

class MyTripsModel extends FlutterFlowModel<MyTripsWidget> {
  ///  State fields for stateful widgets in this page.

  final firestoreService = FirestoreService();
  Future<List<BookingRecord>>? bookingsFuture;

  String selectedTab = 'Upcoming';

  // Model for TabItem.
  late TabItemModel tabItemModel1;
  // Model for TabItem.
  late TabItemModel tabItemModel2;
  // Model for TabItem.
  late TabItemModel tabItemModel3;
  // Model for TripCard.
  late TripCardModel tripCardModel1;
  // Model for TripCard.
  late TripCardModel tripCardModel2;
  // Model for TripCard.
  late TripCardModel tripCardModel3;

  @override
  void initState(BuildContext context) {
    tabItemModel1 = createModel(context, () => TabItemModel());
    tabItemModel2 = createModel(context, () => TabItemModel());
    tabItemModel3 = createModel(context, () => TabItemModel());
    tripCardModel1 = createModel(context, () => TripCardModel());
    tripCardModel2 = createModel(context, () => TripCardModel());
    tripCardModel3 = createModel(context, () => TripCardModel());
  }

  @override
  void dispose() {
    tabItemModel1.dispose();
    tabItemModel2.dispose();
    tabItemModel3.dispose();
    tripCardModel1.dispose();
    tripCardModel2.dispose();
    tripCardModel3.dispose();
  }
}
