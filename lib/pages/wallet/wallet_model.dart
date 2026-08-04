import '/backend/firebase/firestore_service.dart';
import '/backend/schema/wallet_record.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'wallet_widget.dart' show WalletWidget;
import 'package:flutter/material.dart';

class WalletModel extends FlutterFlowModel<WalletWidget> {
  final firestoreService = FirestoreService();
  Future<WalletRecord?>? walletFuture;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
