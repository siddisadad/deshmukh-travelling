import '/components/action_button/action_button_widget.dart';
import '/components/button/button_widget.dart';
import '/components/ticket_detail/ticket_detail_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'booking_confirmation_ticket_widget.dart'
    show BookingConfirmationTicketWidget;
import 'package:flutter/material.dart';

class BookingConfirmationTicketModel
    extends FlutterFlowModel<BookingConfirmationTicketWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TicketDetail.
  late TicketDetailModel ticketDetailModel1;
  // Model for TicketDetail.
  late TicketDetailModel ticketDetailModel2;
  // Model for ActionButton.
  late ActionButtonModel actionButtonModel1;
  // Model for ActionButton.
  late ActionButtonModel actionButtonModel2;
  // Model for ActionButton.
  late ActionButtonModel actionButtonModel3;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    ticketDetailModel1 = createModel(context, () => TicketDetailModel());
    ticketDetailModel2 = createModel(context, () => TicketDetailModel());
    actionButtonModel1 = createModel(context, () => ActionButtonModel());
    actionButtonModel2 = createModel(context, () => ActionButtonModel());
    actionButtonModel3 = createModel(context, () => ActionButtonModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    ticketDetailModel1.dispose();
    ticketDetailModel2.dispose();
    actionButtonModel1.dispose();
    actionButtonModel2.dispose();
    actionButtonModel3.dispose();
    buttonModel.dispose();
  }
}
