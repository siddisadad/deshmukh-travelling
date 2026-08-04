import '/flutter_flow/flutter_flow_util.dart';
import 'all_routes_widget.dart' show AllRoutesWidget;
import 'package:flutter/material.dart';

class AllRoutesModel extends FlutterFlowModel<AllRoutesWidget> {
  final List<Map<String, String>> popularRoutes = [
    {
      'route': 'Mumbai to Pune',
      'price': '499',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Lokhandwala%20Complex%20Mumbai'
    },
    {
      'route': 'Pune to Nashik',
      'price': '350',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Sula%20Vineyards%20Nashik'
    },
    {
      'route': 'Ahmedabad to Surat',
      'price': '550',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Dargah%20Ahmedabad'
    },
    {
      'route': 'Nagpur to Aurangabad',
      'price': '750',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Deekshabhoomi%20Nagpur'
    },
    {
      'route': 'Bangalore to Hyderabad',
      'price': '1100',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Vidhana%20Soudha%20Bangalore'
    },
    {
      'route': 'Mumbai to Goa',
      'price': '1250',
      'img': 'https://dimg.dreamflow.cloud/v1/image/Gateway%20of%20India%20Mumbai'
    },
  ];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
