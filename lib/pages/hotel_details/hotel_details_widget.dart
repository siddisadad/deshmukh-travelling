import '../hotel_booking_confirmation/hotel_booking_confirmation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import '../../backend/schema/hotel_record.dart';
import '../../backend/schema/room_record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hotel_details_model.dart';
export 'hotel_details_model.dart';

class HotelDetailsWidget extends StatefulWidget {
  final HotelRecord hotel;

  const HotelDetailsWidget({
    super.key,
    required this.hotel,
  });

  static String routeName = 'HotelDetails';
  static String routePath = '/hotelDetails';

  @override
  State<HotelDetailsWidget> createState() => _HotelDetailsWidgetState();
}

class _HotelDetailsWidgetState extends State<HotelDetailsWidget> {
  late HotelDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelDetailsModel());
    _model.fetchRooms(widget.hotel.id).then((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: FlutterFlowTheme.of(context).primary,
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
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.hotel.images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.hotel.name,
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).success, size: 20),
                            Text(
                              widget.hotel.rating.toString(),
                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                    color: FlutterFlowTheme.of(context).success,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: FlutterFlowTheme.of(context).secondaryText, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.hotel.location,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(),
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'About',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.hotel.description,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(),
                            lineHeight: 1.5,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Amenities',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.hotel.amenities
                          .map((amenity) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).accent1.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: FlutterFlowTheme.of(context).accent1.withValues(alpha: 0.2)),
                                ),
                                child: Text(
                                  amenity,
                                  style: FlutterFlowTheme.of(context).labelSmall,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Available Rooms',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 16),
                    if (_model.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _model.rooms.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final room = _model.rooms[index];
                          return _roomCard(room);
                        },
                      ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _roomCard(RoomRecord room) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: room.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.type,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  room.amenities.join(' • '),
                  style: FlutterFlowTheme.of(context).labelSmall,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${room.price.toStringAsFixed(0)} / night',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                    ),
                    ButtonWidget(
                      content: 'Select',
                      variant: 'primary',
                      size: 'small',
                      onTap: () {
                        context.pushNamed(
                          HotelBookingConfirmationWidget.routeName,
                          extra: <String, dynamic>{
                            'hotel': widget.hotel,
                            'room': room,
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
