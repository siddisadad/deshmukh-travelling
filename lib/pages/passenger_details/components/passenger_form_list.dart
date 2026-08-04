import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/section_header_a8889900/section_header_a8889900_widget.dart';
import '/components/passenger_form/passenger_form_widget.dart';
import '../passenger_details_model.dart';

class PassengerFormList extends StatelessWidget {
  final PassengerDetailsModel model;
  final VoidCallback onUpdate;

  const PassengerFormList({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderA8889900Widget(
          hasSubtitle: true,
          subtitle: 'Enter details for all selected seats',
          title: 'Passenger Info',
        ),
        for (int index = 0; index < model.passengerFormModels.length; index++)
          wrapWithModel(
            model: model.passengerFormModels[index],
            updateCallback: onUpdate,
            child: PassengerFormWidget(
              number: (index + 1).toString(),
            ),
          ),
      ],
    );
  }
}
