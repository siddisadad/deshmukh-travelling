import '/components/button/button_widget.dart';
import '/components/passenger_form/passenger_form_widget.dart';
import '/components/section_header_a8889900/section_header_a8889900_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'passenger_details_widget.dart' show PassengerDetailsWidget;
import 'package:flutter/material.dart';

class PassengerDetailsModel extends FlutterFlowModel<PassengerDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SectionHeaderA8889900.
  late SectionHeaderA8889900Model sectionHeaderA8889900Model1;
  // Model for PassengerForm.
  late PassengerFormModel passengerFormModel1;
  // Model for PassengerForm.
  late PassengerFormModel passengerFormModel2;
  // Model for SectionHeaderA8889900.
  late SectionHeaderA8889900Model sectionHeaderA8889900Model2;
  // Model for TextField.
  late TextFieldModel textFieldModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel2;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    sectionHeaderA8889900Model1 =
        createModel(context, () => SectionHeaderA8889900Model());
    passengerFormModel1 = createModel(context, () => PassengerFormModel());
    passengerFormModel2 = createModel(context, () => PassengerFormModel());
    sectionHeaderA8889900Model2 =
        createModel(context, () => SectionHeaderA8889900Model());
    textFieldModel1 = createModel(context, () => TextFieldModel());
    textFieldModel2 = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    sectionHeaderA8889900Model1.dispose();
    passengerFormModel1.dispose();
    passengerFormModel2.dispose();
    sectionHeaderA8889900Model2.dispose();
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    buttonModel.dispose();
  }
}
