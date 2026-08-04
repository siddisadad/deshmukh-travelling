import '../hotel_details/hotel_details_widget.dart';
import '/components/hotel_card/hotel_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hotel_search_results_model.dart';
export 'hotel_search_results_model.dart';

class HotelSearchResultsWidget extends StatefulWidget {
  final String? destination;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? guests;

  const HotelSearchResultsWidget({
    super.key,
    this.destination,
    this.checkIn,
    this.checkOut,
    this.guests,
  });

  static String routeName = 'HotelSearchResults';
  static String routePath = '/hotelSearchResults';

  @override
  State<HotelSearchResultsWidget> createState() => _HotelSearchResultsWidgetState();
}

class _HotelSearchResultsWidgetState extends State<HotelSearchResultsWidget> {
  late HotelSearchResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelSearchResultsModel());
    _model.fetchHotels(widget.destination ?? 'Mumbai').then((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.destination ?? 'Mumbai',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.plusJakartaSans(),
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
              ),
              Text(
                '${dateTimeFormat('d MMM', widget.checkIn)} - ${dateTimeFormat('d MMM', widget.checkOut)} • ${widget.guests} Guests',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(),
                      color: FlutterFlowTheme.of(context).onPrimary80,
                    ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: _model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: _model.hotels.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final hotel = _model.hotels[index];
                      return HotelCardWidget(
                        name: hotel.name,
                        location: hotel.location,
                        rating: hotel.rating,
                        reviewsCount: hotel.reviewsCount,
                        image: hotel.images.first,
                        price: hotel.startingPrice,
                        onTap: () {
                          context.pushNamed(
                            HotelDetailsWidget.routeName,
                            extra: <String, dynamic>{
                              'hotel': hotel,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
