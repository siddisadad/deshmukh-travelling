import '/components/button/button_widget.dart';
import '/components/passenger_card/passenger_card_widget.dart';
import '/components/profile_menu_item/profile_menu_item_widget.dart';
import '/components/support_card/support_card_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_settings_widget.dart' show ProfileSettingsWidget;
import 'package:flutter/material.dart';

class ProfileSettingsModel extends FlutterFlowModel<ProfileSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for PassengerCard.
  late PassengerCardModel passengerCardModel1;
  // Model for PassengerCard.
  late PassengerCardModel passengerCardModel2;
  // Model for PassengerCard.
  late PassengerCardModel passengerCardModel3;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel1;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel2;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel3;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel4;
  // Model for Switch.
  late SwitchComponentModel switchModel;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel5;
  // Model for SupportCard.
  late SupportCardModel supportCardModel1;
  // Model for SupportCard.
  late SupportCardModel supportCardModel2;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel6;
  // Model for ProfileMenuItem.
  late ProfileMenuItemModel profileMenuItemModel7;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    passengerCardModel1 = createModel(context, () => PassengerCardModel());
    passengerCardModel2 = createModel(context, () => PassengerCardModel());
    passengerCardModel3 = createModel(context, () => PassengerCardModel());
    profileMenuItemModel1 = createModel(context, () => ProfileMenuItemModel());
    profileMenuItemModel2 = createModel(context, () => ProfileMenuItemModel());
    profileMenuItemModel3 = createModel(context, () => ProfileMenuItemModel());
    profileMenuItemModel4 = createModel(context, () => ProfileMenuItemModel());
    switchModel = createModel(context, () => SwitchComponentModel());
    profileMenuItemModel5 = createModel(context, () => ProfileMenuItemModel());
    supportCardModel1 = createModel(context, () => SupportCardModel());
    supportCardModel2 = createModel(context, () => SupportCardModel());
    profileMenuItemModel6 = createModel(context, () => ProfileMenuItemModel());
    profileMenuItemModel7 = createModel(context, () => ProfileMenuItemModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    passengerCardModel1.dispose();
    passengerCardModel2.dispose();
    passengerCardModel3.dispose();
    profileMenuItemModel1.dispose();
    profileMenuItemModel2.dispose();
    profileMenuItemModel3.dispose();
    profileMenuItemModel4.dispose();
    switchModel.dispose();
    profileMenuItemModel5.dispose();
    supportCardModel1.dispose();
    supportCardModel2.dispose();
    profileMenuItemModel6.dispose();
    profileMenuItemModel7.dispose();
    buttonModel2.dispose();
  }
}
