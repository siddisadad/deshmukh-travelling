import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/firebase/firestore_service.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/material.dart';

class SignupModel extends FlutterFlowModel<SignupWidget> {
  final firestoreService = FirestoreService();

  // Model for Email field
  late TextFieldModel emailModel;
  // Model for Password field
  late TextFieldModel passwordModel;
  // Model for Phone field
  late TextFieldModel phoneModel;
  // Model for Name field
  late TextFieldModel nameModel;

  DateTime? dateOfBirth;

  // Model for Signup Button
  late ButtonModel signupButtonModel;

  @override
  void initState(BuildContext context) {
    emailModel = createModel(context, () => TextFieldModel());
    emailModel.inputTextController = TextEditingController();
    emailModel.inputFocusNode = FocusNode();

    passwordModel = createModel(context, () => TextFieldModel());
    passwordModel.inputTextController = TextEditingController();
    passwordModel.inputFocusNode = FocusNode();

    phoneModel = createModel(context, () => TextFieldModel());
    phoneModel.inputTextController = TextEditingController();
    phoneModel.inputFocusNode = FocusNode();

    nameModel = createModel(context, () => TextFieldModel());
    nameModel.inputTextController = TextEditingController();
    nameModel.inputFocusNode = FocusNode();

    signupButtonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    emailModel.dispose();
    passwordModel.dispose();
    phoneModel.dispose();
    nameModel.dispose();
    signupButtonModel.dispose();
  }
}
