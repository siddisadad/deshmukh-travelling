import '/components/button/button_widget.dart';
import '/components/popular_route_item/popular_route_item_widget.dart';
import '/components/search_input_row/search_input_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_dashboard_widget.dart' show HomeDashboardWidget;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeDashboardModel extends FlutterFlowModel<HomeDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  String selectedService = 'Bus';
  String fromLocation = 'Mumbai, Maharashtra';
  String toLocation = 'Pune, Maharashtra';
  String hotelLocation = 'Mumbai, Maharashtra';
  String holidayLocation = 'Goa, India';
  DateTime? selectedDate = DateTime.now();
  DateTime? checkInDate = DateTime.now();
  DateTime? checkOutDate = DateTime.now().add(const Duration(days: 1));
  int passengerCount = 1;
  int guestCount = 2;
  String citySearchText = '';
  List<String> aiSuggestions = [];

  double walletBalance = 1250.50;
  int rewardPoints = 450;

  List<Map<String, String>> recentSearches = [];
  List<Map<String, String>> recentlyViewed = [];

  final List<Map<String, dynamic>> popularDestinations = [
    {
      'title': 'Goa',
      'subtitle': 'Beaches & Nightlife',
      'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=500&q=80',
      'rating': 4.8,
      'price': 'Starts from ₹2,999',
    },
    {
      'title': 'Manali',
      'subtitle': 'Mountains & Snow',
      'image': 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=500&q=80',
      'rating': 4.7,
      'price': 'Starts from ₹3,499',
    },
    {
      'title': 'Jaipur',
      'subtitle': 'Heritage & Culture',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=500&q=80',
      'rating': 4.9,
      'price': 'Starts from ₹1,999',
    },
  ];

  final List<Map<String, dynamic>> weekendGetaways = [
    {
      'title': 'Lonavala',
      'subtitle': 'Hill Station near Pune',
      'image': 'https://images.unsplash.com/photo-1594993872145-2172778c1872?w=500&q=80',
      'rating': 4.5,
      'price': '₹999 / person',
    },
    {
      'title': 'Alibaug',
      'subtitle': 'Coastal Escape',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&q=80',
      'rating': 4.6,
      'price': '₹1,499 / person',
    },
  ];

  final List<Map<String, dynamic>> nearbyPlaces = [
    {
      'title': 'Gateway of India',
      'subtitle': '2.5 km away',
      'image': 'https://images.unsplash.com/photo-1570160897040-d82611a761b1?w=500&q=80',
      'rating': 4.8,
    },
    {
      'title': 'Marine Drive',
      'subtitle': '4.1 km away',
      'image': 'https://images.unsplash.com/photo-1567157577867-05ccb1388e66?w=500&q=80',
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> recommendations = [
    {
      'title': 'Luxury Bus to Udaipur',
      'subtitle': 'Sleeper • AC • WiFi',
      'image': 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500&q=80',
      'rating': 4.9,
      'price': '₹1,200',
    },
    {
      'title': 'Heritage Hotel stay',
      'subtitle': 'Jodhpur • 5 Star',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
      'rating': 4.8,
      'price': '₹4,500/night',
    },
  ];

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final String? searchesJson = prefs.getString('recent_searches');
    if (searchesJson != null) {
      recentSearches = List<Map<String, dynamic>>.from(json.decode(searchesJson))
          .map((item) => item.map((key, value) => MapEntry(key, value.toString())))
          .toList();
    }

    final String? viewedJson = prefs.getString('recently_viewed');
    if (viewedJson != null) {
      recentlyViewed = List<Map<String, dynamic>>.from(json.decode(viewedJson))
          .map((item) => item.map((key, value) => MapEntry(key, value.toString())))
          .toList();
    } else {
      recentlyViewed = [
        {
          'title': 'Trip to Goa',
          'subtitle': '3 items in your wishlist',
          'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=100&q=80'
        }
      ];
    }
  }

  Future<void> saveRecentlyViewed(String title, String subtitle, String image) async {
    final prefs = await SharedPreferences.getInstance();
    final newItem = {'title': title, 'subtitle': subtitle, 'image': image};

    recentlyViewed.removeWhere((item) => item['title'] == title);
    recentlyViewed.insert(0, newItem);

    if (recentlyViewed.length > 5) {
      recentlyViewed = recentlyViewed.sublist(0, 5);
    }

    await prefs.setString('recently_viewed', json.encode(recentlyViewed));
  }

  Future<void> saveSearch(String from, String to) async {
    final prefs = await SharedPreferences.getInstance();
    final newSearch = {'from': from, 'to': to};

    // Remove if already exists to move to top
    recentSearches.removeWhere((s) => s['from'] == from && s['to'] == to);
    recentSearches.insert(0, newSearch);

    // Keep only last 5
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }

    await prefs.setString('recent_searches', json.encode(recentSearches));
  }

  final List<String> popularCities = [
    'Mumbai, Maharashtra',
    'Pune, Maharashtra',
    'Nagpur, Maharashtra',
    'Nashik, Maharashtra',
    'Aurangabad, Maharashtra',
    'Solapur, Maharashtra',
    'Amravati, Maharashtra',
    'Kolhapur, Maharashtra',
    'Ahmedabad, Gujarat',
    'Surat, Gujarat',
    'Vadodara, Gujarat',
    'Bangalore, Karnataka',
    'Hyderabad, Telangana',
  ];

  void swapLocations() {
    final temp = fromLocation;
    fromLocation = toLocation;
    toLocation = temp;
  }

  Future<void> updateAiSuggestions(String query) async {
    if (query.length < 2) {
      aiSuggestions = [];
      return;
    }
    // Simulate AI suggestion logic (could be Gemini API call)
    await Future.delayed(const Duration(milliseconds: 300));
    final allSuggestions = [
      'Best beaches in Goa for family',
      'Cheap hotels in Mumbai near airport',
      'Weekend trips from Pune for couples',
      'Luxury bus from Ahmedabad to Surat',
      'Trekking packages in Manali',
    ];
    aiSuggestions = allSuggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel1;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel2;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel3;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel1;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel2;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel3;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    searchInputRowModel1 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel2 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel3 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel4 = createModel(context, () => SearchInputRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    popularRouteItemModel1 =
        createModel(context, () => PopularRouteItemModel());
    popularRouteItemModel2 =
        createModel(context, () => PopularRouteItemModel());
    popularRouteItemModel3 =
        createModel(context, () => PopularRouteItemModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    searchInputRowModel1.dispose();
    searchInputRowModel2.dispose();
    searchInputRowModel3.dispose();
    searchInputRowModel4.dispose();
    buttonModel1.dispose();
    popularRouteItemModel1.dispose();
    popularRouteItemModel2.dispose();
    popularRouteItemModel3.dispose();
    buttonModel2.dispose();
  }
}
