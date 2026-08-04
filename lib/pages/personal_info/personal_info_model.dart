import '/backend/firebase/firestore_service.dart';
import '/backend/schema/users_record.dart';
import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'personal_info_widget.dart' show PersonalInfoWidget;
import 'package:flutter/material.dart';

class PersonalInfoModel extends FlutterFlowModel<PersonalInfoWidget> {
  final firestoreService = FirestoreService();
  UsersRecord? userRecord;

  late TextFieldModel nameModel;
  late TextFieldModel emailModel;
  late TextFieldModel phoneModel;
  DateTime? dob;

  late ButtonModel saveButtonModel;

  @override
  void initState(BuildContext context) {
    nameModel = createModel(context, () => TextFieldModel());
    emailModel = createModel(context, () => TextFieldModel());
    phoneModel = createModel(context, () => TextFieldModel());
    saveButtonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    nameModel.dispose();
    emailModel.dispose();
    phoneModel.dispose();
    saveButtonModel.dispose();
  }
}
