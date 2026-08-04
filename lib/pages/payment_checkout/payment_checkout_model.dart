import '/backend/repositories/loyalty_repository.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/firebase/firestore_service.dart';
import '/components/button/button_widget.dart';
import '/components/payment_method_tile/payment_method_tile_widget.dart';
import '/components/price_summary_row/price_summary_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

class PaymentCheckoutModel extends FlutterFlowModel<PaymentCheckoutWidget> {
  ///  State fields for stateful widgets in this page.

  final firestoreService = FirestoreService();
  final loyaltyRepository = MockLoyaltyRepository();

  CouponRecord? appliedCoupon;
  bool useWallet = false;
  double walletBalance = 500.0;

  TextEditingController? couponController;

  // Model for PaymentMethodTile.
  late PaymentMethodTileModel paymentMethodTileModel1;
  // Model for PaymentMethodTile.
  late PaymentMethodTileModel paymentMethodTileModel2;
  // Model for PaymentMethodTile.
  late PaymentMethodTileModel paymentMethodTileModel3;
  // Model for PaymentMethodTile.
  late PaymentMethodTileModel paymentMethodTileModel4;
  // Model for PriceSummaryRow.
  late PriceSummaryRowModel priceSummaryRowModel1;
  // Model for PriceSummaryRow.
  late PriceSummaryRowModel priceSummaryRowModel2;
  // Model for PriceSummaryRow.
  late PriceSummaryRowModel priceSummaryRowModel3;
  // Model for PriceSummaryRow.
  late PriceSummaryRowModel priceSummaryRowModel4;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    paymentMethodTileModel1 =
        createModel(context, () => PaymentMethodTileModel());
    paymentMethodTileModel2 =
        createModel(context, () => PaymentMethodTileModel());
    paymentMethodTileModel3 =
        createModel(context, () => PaymentMethodTileModel());
    paymentMethodTileModel4 =
        createModel(context, () => PaymentMethodTileModel());
    priceSummaryRowModel1 = createModel(context, () => PriceSummaryRowModel());
    priceSummaryRowModel2 = createModel(context, () => PriceSummaryRowModel());
    priceSummaryRowModel3 = createModel(context, () => PriceSummaryRowModel());
    priceSummaryRowModel4 = createModel(context, () => PriceSummaryRowModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    paymentMethodTileModel1.dispose();
    paymentMethodTileModel2.dispose();
    paymentMethodTileModel3.dispose();
    paymentMethodTileModel4.dispose();
    priceSummaryRowModel1.dispose();
    priceSummaryRowModel2.dispose();
    priceSummaryRowModel3.dispose();
    priceSummaryRowModel4.dispose();
    buttonModel.dispose();
  }
}
