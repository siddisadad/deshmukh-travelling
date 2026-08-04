import '/flutter_flow/flutter_flow_util.dart';
import 'taxi_search_results_widget.dart' show TaxiSearchResultsWidget;
import 'package:flutter/material.dart';

class TaxiSearchResult {
  final String name;
  final String type;
  final double rating;
  final String price;
  final String image;
  final String estimatedTime;

  TaxiSearchResult({
    required this.name,
    required this.type,
    required this.rating,
    required this.price,
    required this.image,
    required this.estimatedTime,
  });
}

class TaxiSearchResultsModel extends FlutterFlowModel<TaxiSearchResultsWidget> {
  bool isLoading = true;
  List<TaxiSearchResult> taxis = [];

  Future<void> fetchTaxis() async {
    isLoading = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    taxis = [
      TaxiSearchResult(
        name: 'Prime Sedan',
        type: 'Sedan',
        rating: 4.8,
        price: '₹850',
        image: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=500&q=80',
        estimatedTime: '8 mins',
      ),
      TaxiSearchResult(
        name: 'SUV Premium',
        type: 'SUV',
        rating: 4.9,
        price: '₹1,200',
        image: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=500&q=80',
        estimatedTime: '12 mins',
      ),
      TaxiSearchResult(
        name: 'Mini Eco',
        type: 'Hatchback',
        rating: 4.6,
        price: '₹600',
        image: 'https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?w=500&q=80',
        estimatedTime: '5 mins',
      ),
    ];
    isLoading = false;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
