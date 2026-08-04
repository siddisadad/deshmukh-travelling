import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'passenger_form_widget.dart' show PassengerFormWidget;
import 'package:flutter/material.dart';

class PassengerFormModel extends FlutterFlowModel<PassengerFormWidget> {
  ///  State fields for stateful widgets in this component.

  String get name => textFieldModel1.inputTextController?.text ?? '';
  int get age => int.tryParse(textFieldModel2.inputTextController?.text ?? '') ?? 0;
  String get gender => dropdownValue ?? 'Male';

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
    textFieldModel1.inputTextController = TextEditingController();
    textFieldModel1.inputFocusNode = FocusNode();

    textFieldModel2 = createModel(context, () => TextFieldModel());
    textFieldModel2.inputTextController = TextEditingController();
    textFieldModel2.inputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
  }
}
