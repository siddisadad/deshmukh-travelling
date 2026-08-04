import '/components/button/button_widget.dart';
import '/components/feature_item/feature_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/firebase/firestore_service.dart';
import 'login_o_t_p_widget.dart' show LoginOTPWidget;
import 'package:flutter/material.dart';

class LoginOTPModel extends FlutterFlowModel<LoginOTPWidget> {
  final firestoreService = FirestoreService();
  ///  State fields for stateful widgets in this page.

  bool isOtpSent = false;
  String phoneNumber = '';

  // Model for TextField (Phone).
  late TextFieldModel textFieldModel;
  // Model for TextField (OTP).
  late TextFieldModel otpFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel1;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel2;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel3;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    textFieldModel.inputTextController = TextEditingController();
    textFieldModel.inputFocusNode = FocusNode();

    otpFieldModel = createModel(context, () => TextFieldModel());
    otpFieldModel.inputTextController = TextEditingController();
    otpFieldModel.inputFocusNode = FocusNode();

    buttonModel = createModel(context, () => ButtonModel());
    featureItemModel1 = createModel(context, () => FeatureItemModel());
    featureItemModel2 = createModel(context, () => FeatureItemModel());
    featureItemModel3 = createModel(context, () => FeatureItemModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    otpFieldModel.dispose();
    buttonModel.dispose();
    featureItemModel1.dispose();
    featureItemModel2.dispose();
    featureItemModel3.dispose();
  }
}
