import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/package_record.dart';
import '../../backend/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class PackageListingModel extends FlutterFlowModel {
  final firestoreService = FirestoreService();
  List<PackageRecord> packages = [];
  bool isLoading = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchPackages() async {
    isLoading = true;
    packages = await firestoreService.fetchPackages();
    isLoading = false;
  }
}
