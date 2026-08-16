import '/components/button/button_widget.dart';
import '/components/price_summary_row/price_summary_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/backend/schema/buses_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_checkout_model.dart';
export 'payment_checkout_model.dart';

class PaymentCheckoutWidget extends StatefulWidget {
  const PaymentCheckoutWidget({
    super.key,
    this.selectedSeats,
    this.busRef,
  });

  final List<String>? selectedSeats;
  final DocumentReference? busRef;

  static String routeName = 'PaymentCheckout';
  static String routePath = '/paymentCheckout';

  @override
  State<PaymentCheckoutWidget> createState() => _PaymentCheckoutWidgetState();
}

class _PaymentCheckoutWidgetState extends State<PaymentCheckoutWidget> {
  late PaymentCheckoutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentCheckoutModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: StreamBuilder<BusesRecord>(
          stream: widget.busRef != null
              ? widget.busRef!.snapshots().map((s) => BusesRecord.fromSnapshot(s))
              : Stream.empty(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final bus = snapshot.data!;
            final numSeats = widget.selectedSeats?.length ?? 0;
            final basePrice = bus.price * numSeats;
            final bookingFee = 50.0;
            final gst = basePrice * 0.05;
            final totalAmount = basePrice + bookingFee + gst;

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Checkout',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).accent4,
                                      borderRadius: BorderRadius.circular(16.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Departure',
                                                    style: FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts.inter(),
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.4,
                                                        ),
                                                  ),
                                                  Text(
                                                    bus.depTime,
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          lineHeight: 1.5,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.east_rounded,
                                                color: FlutterFlowTheme.of(context).onSurface,
                                                size: 20.0,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Arrival',
                                                    style: FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts.inter(),
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.4,
                                                        ),
                                                  ),
                                                  Text(
                                                    bus.arrTime,
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          lineHeight: 1.5,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 12.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Price Details',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                          wrapWithModel(
                                            model: _model.priceSummaryRowModel1,
                                            updateCallback: () => safeSetState(() {}),
                                            child: PriceSummaryRowWidget(
                                              label: 'Base Fare ($numSeats Seats)',
                                              value: '₹${formatNumber(basePrice, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                            ),
                                          ),
                                          wrapWithModel(
                                            model: _model.priceSummaryRowModel2,
                                            updateCallback: () => safeSetState(() {}),
                                            child: PriceSummaryRowWidget(
                                              label: 'Booking Fee',
                                              value: '₹50',
                                            ),
                                          ),
                                          wrapWithModel(
                                            model: _model.priceSummaryRowModel3,
                                            updateCallback: () => safeSetState(() {}),
                                            child: PriceSummaryRowWidget(
                                              color: FlutterFlowTheme.of(context).primary,
                                              isTotal: 'true',
                                              label: 'Taxes (GST 5%)',
                                              value: '₹${formatNumber(gst, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                            ),
                                          ),
                                          Divider(
                                            height: 16.0,
                                            thickness: 1.0,
                                            indent: 0.0,
                                            endIndent: 0.0,
                                            color: FlutterFlowTheme.of(context).alternate,
                                          ),
                                          wrapWithModel(
                                            model: _model.priceSummaryRowModel4,
                                            updateCallback: () => safeSetState(() {}),
                                            child: PriceSummaryRowWidget(
                                              color: FlutterFlowTheme.of(context).primary,
                                              isTotal: 'true',
                                              label: 'Total Amount',
                                              value: '₹${formatNumber(totalAmount, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 24.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹${formatNumber(totalAmount, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w800,
                                          ),
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w800,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Text(
                                    'Total Amount',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // 1. Create booking record
                                    final bookingRef = FirebaseFirestore.instance.collection('bookings').doc();
                                    await bookingRef.set({
                                      'busRef': widget.busRef,
                                      'seats': widget.selectedSeats,
                                      'amount': totalAmount,
                                      'status': 'confirmed',
                                      'timestamp': FieldValue.serverTimestamp(),
                                    });

                                    // 2. Update seat statuses
                                    if (widget.busRef != null && widget.selectedSeats != null) {
                                      final seatsQuery = await widget.busRef!.collection('seats').get();
                                      for (var doc in seatsQuery.docs) {
                                        if (widget.selectedSeats!.contains(doc.data()['number'])) {
                                          await doc.reference.update({'status': 'booked'});
                                        }
                                      }
                                    }

                                    // 3. Navigate to My Trips
                                    context.goNamed(MyTripsWidget.routeName);
                                  },
                                  child: wrapWithModel(
                                    model: _model.buttonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      icon: Icon(
                                        Icons.lock_rounded,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        size: 24.0,
                                      ),
                                      iconPresent: true,
                                      iconEndPresent: false,
                                      content: 'Pay Now',
                                      variant: 'primary',
                                      size: 'large',
                                      fullWidth: false,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 24.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
