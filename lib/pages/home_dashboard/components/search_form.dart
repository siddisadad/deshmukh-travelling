import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/search_input_row/search_input_row_widget.dart';
import '/components/button/button_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../home_dashboard_model.dart';

class SearchForm extends StatelessWidget {
  final HomeDashboardModel model;
  final VoidCallback onSwap;
  final Function(bool) onPickLocation;
  final VoidCallback onPickDate;
  final VoidCallback onPickPassengers;
  final VoidCallback onSearch;

  const SearchForm({
    super.key,
    required this.model,
    required this.onSwap,
    required this.onPickLocation,
    required this.onPickDate,
    required this.onPickPassengers,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    bool isHotel = model.selectedService == 'Hotel';
    bool isHoliday = model.selectedService == 'Holiday';
    bool isTaxi = model.selectedService == 'Taxi';
    bool isBus = model.selectedService == 'Bus';

    String searchButtonLabel = AppLocalizations.of(context)!.searchBuses;
    if (isHotel) searchButtonLabel = 'Search Hotels';
    if (isTaxi) searchButtonLabel = 'Find Taxis';
    if (isHoliday) searchButtonLabel = 'Explore Holidays';

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.lg),
        shape: BoxShape.rectangle,
        boxShadow: [FlutterFlowTheme.of(context).designToken.shadow.md],
      ),
      child: Padding(
        padding:
            EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isBus || isTaxi)
              Stack(
                alignment: const AlignmentDirectional(-1.0, -1.0),
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => onPickLocation(true),
                        child: SearchInputRowWidget(
                          icon: Icon(
                            isTaxi ? Icons.my_location_rounded : Icons.location_on_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 22.0,
                          ),
                          label: isTaxi ? 'Pickup Location' : AppLocalizations.of(context)!.from,
                          value: model.fromLocation,
                        ),
                      ),
                      InkWell(
                        onTap: () => onPickLocation(false),
                        child: SearchInputRowWidget(
                          icon: Icon(
                            isTaxi ? Icons.local_taxi_rounded : Icons.directions_bus_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 22.0,
                          ),
                          label: isTaxi ? 'Drop Location' : AppLocalizations.of(context)!.to,
                          value: model.toLocation,
                        ),
                      ),
                    ].divide(SizedBox(
                        height: FlutterFlowTheme.of(context)
                            .designToken
                            .spacing
                            .sm)),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.85, 0.0),
                    child: InkWell(
                      onTap: onSwap,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .full),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: Icon(
                          Icons.swap_vert_rounded,
                          color: FlutterFlowTheme.of(context).onSurface,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              InkWell(
                onTap: () => onPickLocation(true),
                child: SearchInputRowWidget(
                  icon: Icon(
                    Icons.location_on_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 22.0,
                  ),
                  label: 'Destination',
                  value: isHotel ? model.hotelLocation : model.holidayLocation,
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: onPickDate,
                    child: SearchInputRowWidget(
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 22.0,
                      ),
                      label: isHotel ? 'Check-in' : AppLocalizations.of(context)!.date,
                      value: dateTimeFormat(
                        'd MMM, y',
                        isHotel ? model.checkInDate : model.selectedDate,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: onPickPassengers,
                    child: SearchInputRowWidget(
                      icon: Icon(
                        isHotel ? Icons.people_rounded : Icons.person_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 22.0,
                      ),
                      label: isHotel ? 'Guests' : AppLocalizations.of(context)!.passengers,
                      value: isHotel ? '${model.guestCount} Guests' : '${model.passengerCount} Adult',
                    ),
                  ),
                ),
              ].divide(SizedBox(
                  width: FlutterFlowTheme.of(context).designToken.spacing.md)),
            ),
            wrapWithModel(
              model: model.buttonModel1,
              updateCallback: () {},
              child: ButtonWidget(
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
                iconPresent: true,
                iconEndPresent: false,
                content: searchButtonLabel,
                variant: 'primary',
                size: 'large',
                fullWidth: true,
                loading: false,
                disabled: false,
                onTap: onSearch,
              ),
            ),
          ].divide(SizedBox(
              height: FlutterFlowTheme.of(context).designToken.spacing.md)),
        ),
      ),
    );
  }
}
