import '/auth/firebase_auth/auth_util.dart';
import '/components/button/button_widget.dart';
import '/components/payment_method_tile/payment_method_tile_widget.dart';
import '/components/price_summary_row/price_summary_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_checkout_model.dart';
export 'payment_checkout_model.dart';

class PaymentCheckoutWidget extends StatefulWidget {
  const PaymentCheckoutWidget({
    super.key,
    this.booking,
  });

  final BookingRecord? booking;

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

    _loadWallet();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadWallet() async {
    final wallet = await _model.firestoreService.getWallet(currentUserUid);
    if (wallet != null) {
      safeSetState(() {
        _model.walletBalance = wallet.balance;
      });
    }
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg,
                        vertical: FlutterFlowTheme.of(context).designToken.spacing.md),
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
                              context.goNamed(SeatSelectionWidget.routeName);
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.payment,
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
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
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.booking?.busName ?? 'Shivneri Express',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .plusJakartaSans(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                        lineHeight: 1.45,
                                                      ),
                                                ),
                                                Text(
                                                  '${widget.booking?.busType ?? 'AC Sleeper'} • ${widget.booking?.seatNumbers.join(', ') ?? '2B, 2C'}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary10,
                                                borderRadius:
                                                    BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.sm),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 4.0, 8.0, 4.0),
                                                child: Container(
                                                  child: Text(
                                                    'DS-9842',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .onPrimary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                          lineHeight: 1.4,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 16.0,
                                          thickness: 1.0,
                                          indent: 0.0,
                                          endIndent: 0.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.departure,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                                Text(
                                                  '08:30 PM',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.east_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onSurface,
                                              size: 20.0,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.arrival,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                                Text(
                                                  '04:30 AM',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 16.0,
                                          thickness: 1.0,
                                          indent: 0.0,
                                          endIndent: 0.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.event_seat_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 20.0,
                                            ),
                                            Text(
                                              'Seats: 14, 15',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '2 Passengers',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Offers & Coupons',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.45,
                                        ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  _model.couponController ??=
                                                      TextEditingController(),
                                              decoration: const InputDecoration(
                                                hintText: 'Enter Promo Code',
                                                border: InputBorder.none,
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              final code = _model
                                                  .couponController?.text;
                                              if (code != null &&
                                                  code.isNotEmpty) {
                                                final coupon = await _model
                                                    .loyaltyRepository
                                                    .getCoupon(code);
                                                if (coupon != null) {
                                                  setState(() {
                                                    _model.appliedCoupon =
                                                        coupon;
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Coupon applied successfully!')),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Invalid coupon code')),
                                                  );
                                                }
                                              }
                                            },
                                            child: const Text('APPLY'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (_model.appliedCoupon != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '✓ Coupon "${_model.appliedCoupon!.code}" applied! You save ₹${_model.appliedCoupon!.discountAmount.toInt()}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .copyWith(
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .success),
                                      ),
                                    ),
                                ].divide(const SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Select Payment Method',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.45,
                                        ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_balance_wallet,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Deshmukh Wallet',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    '${AppLocalizations.of(context)!.walletBalance}: ₹${_model.walletBalance.toInt()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Switch.adaptive(
                                            value: _model.useWallet,
                                            onChanged: (val) {
                                              setState(() {
                                                _model.useWallet = val;
                                              });
                                            },
                                            activeTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.paymentMethodTileModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PaymentMethodTileWidget(
                                      icon: 'googlepay',
                                      subtitle:
                                          'Pay instantly with any UPI app',
                                      title: 'Google Pay / UPI',
                                      selected: true,
                                      type: 'upi',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.paymentMethodTileModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PaymentMethodTileWidget(
                                      icon: 'googlepay',
                                      subtitle: 'Visa, Mastercard, RuPay',
                                      title: 'Credit / Debit Card',
                                      selected: false,
                                      type: 'card',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.paymentMethodTileModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PaymentMethodTileWidget(
                                      icon: 'googlepay',
                                      subtitle: 'Paytm, Amazon Pay, etc.',
                                      title: 'Wallets',
                                      selected: false,
                                      type: 'wallet',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.paymentMethodTileModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PaymentMethodTileWidget(
                                      icon: 'googlepay',
                                      subtitle: 'All major Indian banks',
                                      title: 'Net Banking',
                                      selected: false,
                                      type: 'bank',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Price Summary',
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                  wrapWithModel(
                                    model: _model.priceSummaryRowModel1,
                                    updateCallback: () =>
                                        safeSetState(() {}),
                                    child: PriceSummaryRowWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      isTotal: 'true',
                                      label: AppLocalizations.of(context)!.baseFare,
                                      value: '₹${((widget.booking?.totalAmount ?? 1316.0) - 116).toInt()}',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.priceSummaryRowModel2,
                                    updateCallback: () =>
                                        safeSetState(() {}),
                                    child: PriceSummaryRowWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      isTotal: 'true',
                                      label: AppLocalizations.of(context)!.convenienceFee,
                                      value: '₹50',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.priceSummaryRowModel3,
                                    updateCallback: () =>
                                        safeSetState(() {}),
                                    child: PriceSummaryRowWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      isTotal: 'true',
                                      label: AppLocalizations.of(context)!.taxes,
                                      value: '₹66',
                                    ),
                                  ),
                                  if (_model.appliedCoupon != null)
                                    wrapWithModel(
                                      model: _model.priceSummaryRowModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: PriceSummaryRowWidget(
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        isTotal: 'false',
                                        label: AppLocalizations.of(context)!.couponDiscount,
                                        value: '-₹${_model.appliedCoupon!.discountAmount.toInt()}',
                                      ),
                                    ),
                                  if (_model.useWallet)
                                    wrapWithModel(
                                      model: _model.priceSummaryRowModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: PriceSummaryRowWidget(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        isTotal: 'false',
                                        label: AppLocalizations.of(context)!.walletPayment,
                                        value: '-₹${min(_model.walletBalance, (widget.booking?.totalAmount ?? 1316.0) - (_model.appliedCoupon?.discountAmount ?? 0)).toInt()}',
                                      ),
                                    ),
                                  Divider(
                                    height: 16.0,
                                    thickness: 1.0,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                    color: FlutterFlowTheme.of(context)
                                        .alternate,
                                  ),
                                  wrapWithModel(
                                    model: _model.priceSummaryRowModel4,
                                    updateCallback: () =>
                                        safeSetState(() {}),
                                    child: PriceSummaryRowWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      isTotal: 'true',
                                      label: AppLocalizations.of(context)!.totalAmount,
                                      value: '₹${max(0, (widget.booking?.totalAmount ?? 1316.0) - (_model.appliedCoupon?.discountAmount ?? 0) - (_model.useWallet ? min(_model.walletBalance, (widget.booking?.totalAmount ?? 1316.0) - (_model.appliedCoupon?.discountAmount ?? 0)) : 0)).toInt()}',
                                    ),
                                  ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified_user_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onBackground,
                                      size: 18.0,
                                    ),
                                    Text(
                                      '100% Safe & Secure Payments',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onBackground,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
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
                    padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
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
                                '₹1,316',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                'View Details',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      decoration: TextDecoration.underline,
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
                                if (widget.booking != null) {
                                  // 1. Deduct from wallet if used
                                  if (_model.useWallet) {
                                    final walletDeduction = min(
                                      _model.walletBalance,
                                      (widget.booking?.totalAmount ?? 1316.0) -
                                          (_model.appliedCoupon?.discountAmount ?? 0),
                                    );
                                    if (walletDeduction > 0) {
                                      await _model.firestoreService.updateWalletBalance(
                                        currentUserUid,
                                        walletDeduction,
                                        'debit',
                                        'Payment for Bus ${widget.booking?.busName}',
                                      );
                                    }
                                  }

                                  // 2. Create the booking record
                                  await _model.firestoreService
                                      .createBooking(widget.booking!);

                                  // 3. Add Loyalty Points
                                  await _model.firestoreService.addLoyaltyPoints(currentUserUid, 50);
                                }

                                context.goNamed(
                                  BookingConfirmationTicketWidget.routeName,
                                  queryParameters: {
                                    'booking': serializeParam(
                                      widget.booking,
                                      ParamType.JSON,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  icon: Icon(
                                    Icons.lock_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
        ),
      ),
    );
  }
}
