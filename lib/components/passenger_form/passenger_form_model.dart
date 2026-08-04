import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'passenger_form_widget.dart' show PassengerFormWidget;
import 'package:flutter/material.dart';

class PassengerFormModel extends FlutterFlowModel<PassengerFormWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TextField.
  late TextFieldModel textFieldModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel2;
  // State field(s) for Dropdown widget.
  String? dropdownValue;
  FormFieldController<String>? dropdownValueController;

  @override
  void initState(BuildContext context) {
    textFieldModel1 = createModel(context, () => TextFieldModel());
    textFieldModel2 = createModel(context, () => TextFieldModel());
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
  }
}
