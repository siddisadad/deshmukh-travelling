import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '../../backend/schema/hotel_record.dart';
import '../../backend/schema/room_record.dart';
import '../../backend/schema/hotel_booking_record.dart';
import '../booking_confirmation_ticket/booking_confirmation_ticket_widget.dart';
import '../home_dashboard/home_dashboard_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hotel_booking_confirmation_model.dart';
export 'hotel_booking_confirmation_model.dart';

class HotelBookingConfirmationWidget extends StatefulWidget {
  final HotelRecord hotel;
  final RoomRecord room;

  const HotelBookingConfirmationWidget({
    super.key,
    required this.hotel,
    required this.room,
  });

  static String routeName = 'HotelBookingConfirmation';
  static String routePath = '/hotelBookingConfirmation';

  @override
  State<HotelBookingConfirmationWidget> createState() =>
      _HotelBookingConfirmationWidgetState();
}

class _HotelBookingConfirmationWidgetState
    extends State<HotelBookingConfirmationWidget> {
  late HotelBookingConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelBookingConfirmationModel());
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Booking Confirmation',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.plusJakartaSans(),
                color: Colors.white,
                fontSize: 20.0,
              ),
        ),
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: widget.hotel.images.first,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.hotel.name,
                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                          font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                        ),
                                  ),
                                  Text(
                                    widget.hotel.location,
                                    style: FlutterFlowTheme.of(context).labelSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.room.type,
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Booking Details',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                            ),
                      ),
                      const SizedBox(height: 12),
                      _detailRow('Check-in', '15 Aug, 2026 (12:00 PM)'),
                      _detailRow('Check-out', '16 Aug, 2026 (11:00 AM)'),
                      _detailRow('Guests', '2 Adults'),
                      _detailRow('Duration', '1 Night'),
                      const SizedBox(height: 24),
                      Text(
                        'Fare Details',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                            ),
                      ),
                      const SizedBox(height: 12),
                      _fareRow('Room Charges (1 Night)', '₹${widget.room.price.toStringAsFixed(0)}'),
                      _fareRow('Taxes & Fees', '₹${(widget.room.price * 0.12).toStringAsFixed(0)}'),
                      const Divider(height: 24),
                      _fareRow('Total Amount', '₹${(widget.room.price * 1.12).toStringAsFixed(0)}', isTotal: true),
                    ],
                  ),
                ),
              ),
              ButtonWidget(
                content: 'Proceed to Pay',
                variant: 'primary',
                size: 'large',
                fullWidth: true,
                onTap: () async {
                  final booking = HotelBookingRecord(
                    id: '', // Will be set by Firestore
                    userId: currentUserUid,
                    hotelId: widget.hotel.id,
                    roomId: widget.room.id,
                    checkIn: DateTime.now().add(const Duration(days: 7)), // Placeholder
                    checkOut: DateTime.now().add(const Duration(days: 8)), // Placeholder
                    totalPrice: widget.room.price * 1.12,
                    status: 'confirmed',
                    guestCount: 2,
                    createdAt: DateTime.now(),
                  );

                  await _model.firestoreService.createHotelBooking(booking);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hotel booking successful!')),
                  );
                  context.goNamed(HomeDashboardWidget.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: FlutterFlowTheme.of(context).labelMedium),
          Text(value, style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  Widget _fareRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                    )
                : FlutterFlowTheme.of(context).labelMedium,
          ),
          Text(
            value,
            style: isTotal
                ? FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    )
                : FlutterFlowTheme.of(context).bodyMedium,
          ),
        ],
      ),
    );
  }
}
