import '../bus_search_results/bus_search_results_widget.dart';
import '../hotel_search_results/hotel_search_results_widget.dart';
import '../package_listing/package_listing_widget.dart';
import '../ai_assistant/ai_assistant_widget.dart';
import '../notifications/notifications_widget.dart';
import '../taxi_booking/taxi_booking_widget.dart';
import '../car_rental/car_rental_widget.dart';
import '../all_routes/all_routes_widget.dart';
import 'components/search_form.dart';
import 'components/wallet_summary.dart';
import 'components/ai_assistant_fab.dart';
import 'components/ai_search_suggestions.dart';
import '../../components/premium_card/premium_card_widget.dart';
import '/components/button/button_widget.dart';
import '/components/popular_route_item/popular_route_item_widget.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';
import 'home_dashboard_model.dart';
export 'home_dashboard_model.dart';

class HomeDashboardWidget extends StatefulWidget {
  const HomeDashboardWidget({super.key});

  static String routeName = 'HomeDashboard';
  static String routePath = '/homeDashboard';

  @override
  State<HomeDashboardWidget> createState() => _HomeDashboardWidgetState();
}

class _HomeDashboardWidgetState extends State<HomeDashboardWidget> {
  late HomeDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeDashboardModel());

    _model.loadRecentSearches().then((_) => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _showLocationPicker(bool isFrom) async {
    final selectedCity = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final List<String> filteredCities = _model.popularCities
                .where((city) => city
                    .toLowerCase()
                    .contains(_model.citySearchText.toLowerCase()))
                .toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      isFrom
                          ? AppLocalizations.of(context)!.selectOrigin
                          : AppLocalizations.of(context)!.selectDestination,
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchCity,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          _model.citySearchText = value;
                        });
                        _model.updateAiSuggestions(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: filteredCities.isEmpty
                        ? Center(
                            child: Text(
                              'No cities found',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredCities.length,
                            itemBuilder: (context, index) {
                              final city = filteredCities[index];
                              return ListTile(
                                title: Text(city),
                                leading: const Icon(Icons.location_on_outlined),
                                onTap: () => Navigator.pop(context, city),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      _model.citySearchText = '';
      return value;
    });

    if (selectedCity != null) {
      safeSetState(() {
        if (_model.selectedService == 'Hotel') {
          _model.hotelLocation = selectedCity;
        } else {
          if (isFrom) {
            _model.fromLocation = selectedCity;
          } else {
            _model.toLocation = selectedCity;
          }
        }
      });
    }
  }

  Future<void> _showPassengerPicker() async {
    final count = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Passengers',
                style: FlutterFlowTheme.of(context).titleLarge,
              ),
              const SizedBox(height: 24.0),
              StatefulBuilder(
                builder: (context, setModalState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 44.0,
                        fillColor: FlutterFlowTheme.of(context).alternate,
                        icon: Icon(
                          Icons.remove,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: _model.passengerCount > 1
                            ? () => setModalState(() => _model.passengerCount--)
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          _model.passengerCount.toString(),
                          style: FlutterFlowTheme.of(context).displaySmall,
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 44.0,
                        fillColor: FlutterFlowTheme.of(context).alternate,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: _model.passengerCount < 10
                            ? () => setModalState(() => _model.passengerCount++)
                            : null,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32.0),
              ButtonWidget(
                content: 'Done',
                variant: 'primary',
                size: 'large',
                fullWidth: true,
                onTap: () => Navigator.pop(context, _model.passengerCount),
              ),
            ],
          ),
        );
      },
    );

    if (count != null) {
      safeSetState(() {});
    }
  }

  Widget _serviceItem(String label, IconData icon) {
    bool isSelected = _model.selectedService == label;
    return InkWell(
      onTap: () {
        setState(() {
          _model.selectedService = label;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected
                  ? FlutterFlowTheme.of(context).secondary
                  : FlutterFlowTheme.of(context).onPrimary10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? FlutterFlowTheme.of(context).onSurface
                  : FlutterFlowTheme.of(context).onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.inter(),
                  color: isSelected
                      ? FlutterFlowTheme.of(context).onPrimary
                      : FlutterFlowTheme.of(context).onPrimary80,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _showGuestPicker() async {
    final count = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Guests',
                style: FlutterFlowTheme.of(context).titleLarge,
              ),
              const SizedBox(height: 24.0),
              StatefulBuilder(
                builder: (context, setModalState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 44.0,
                        fillColor: FlutterFlowTheme.of(context).alternate,
                        icon: Icon(
                          Icons.remove,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: _model.guestCount > 1
                            ? () => setModalState(() => _model.guestCount--)
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          _model.guestCount.toString(),
                          style: FlutterFlowTheme.of(context).displaySmall,
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 44.0,
                        fillColor: FlutterFlowTheme.of(context).alternate,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: _model.guestCount < 10
                            ? () => setModalState(() => _model.guestCount++)
                            : null,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32.0),
              ButtonWidget(
                content: 'Done',
                variant: 'primary',
                size: 'large',
                fullWidth: true,
                onTap: () => Navigator.pop(context, _model.guestCount),
              ),
            ],
          ),
        );
      },
    );

    if (count != null) {
      safeSetState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: AiAssistantFab(
          onTap: () {
            context.pushNamed(AiAssistantWidget.routeName);
          },
        ),
        body: SingleChildScrollView(
          primary: true,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                    bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.appTitle,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                Text(
                                  'Explore the world with ease',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.inter(),
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary80,
                                        lineHeight: 1.6,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 9999.0,
                              buttonSize: 40.0,
                              fillColor:
                                  FlutterFlowTheme.of(context).onPrimary10,
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.pushNamed(NotificationsWidget.routeName);
                              },
                            ),
                          ],
                        ),
                        // Service Selector
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _serviceItem('Bus', Icons.directions_bus_rounded),
                              _serviceItem('Hotel', Icons.hotel_rounded),
                              _serviceItem('Taxi', Icons.local_taxi_rounded),
                              _serviceItem('Holiday', Icons.beach_access_rounded),
                              _serviceItem('Rentals', Icons.car_rental_rounded),
                            ].divide(const SizedBox(width: 12.0)),
                          ),
                        ),
                        SearchForm(
                          model: _model,
                          onSwap: () {
                            setState(() {
                              _model.swapLocations();
                            });
                          },
                          onPickLocation: (isFrom) =>
                              _showLocationPicker(isFrom),
                          onPickDate: () async {
                            if (_model.selectedService == 'Hotel') {
                              final dateRange = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                                initialDateRange: DateTimeRange(
                                  start: _model.checkInDate ?? DateTime.now(),
                                  end: _model.checkOutDate ??
                                      DateTime.now().add(const Duration(days: 1)),
                                ),
                              );
                              if (dateRange != null) {
                                safeSetState(() {
                                  _model.checkInDate = dateRange.start;
                                  _model.checkOutDate = dateRange.end;
                                });
                              }
                            } else {
                              final datePickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    _model.selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );
                              if (datePickedDate != null) {
                                safeSetState(() {
                                  _model.selectedDate = datePickedDate;
                                });
                              }
                            }
                          },
                          onPickPassengers: () => _model.selectedService == 'Hotel'
                              ? _showGuestPicker()
                              : _showPassengerPicker(),
                          onSearch: () async {
                            if (_model.selectedService == 'Hotel') {
                              context.pushNamed(
                                HotelSearchResultsWidget.routeName,
                                queryParameters: {
                                  'destination': serializeParam(
                                      _model.hotelLocation, ParamType.String),
                                  'checkIn': serializeParam(
                                      _model.checkInDate, ParamType.DateTime),
                                  'checkOut': serializeParam(
                                      _model.checkOutDate, ParamType.DateTime),
                                  'guests': serializeParam(
                                      _model.guestCount, ParamType.int),
                                }.withoutNulls,
                              );
                            } else if (_model.selectedService == 'Holiday') {
                              context.pushNamed(PackageListingWidget.routeName);
                            } else if (_model.selectedService == 'Taxi') {
                              context.pushNamed(TaxiBookingWidget.routeName);
                            } else if (_model.selectedService == 'Rentals') {
                              context.pushNamed(CarRentalWidget.routeName);
                            } else {
                              await _model.saveSearch(
                                  _model.fromLocation, _model.toLocation);
                              context.pushNamed(
                                BusSearchResultsWidget.routeName,
                                queryParameters: {
                                  'fromLocation': serializeParam(
                                      _model.fromLocation, ParamType.String),
                                  'toLocation': serializeParam(
                                      _model.toLocation, ParamType.String),
                                  'date': serializeParam(
                                      _model.selectedDate, ParamType.DateTime),
                                }.withoutNulls,
                              );
                            }
                          },
                        ),
                        AiSearchSuggestions(
                          suggestions: _model.aiSuggestions,
                          onSelected: (val) {
                            setState(() {
                              _model.aiSuggestions = [];
                            });
                          },
                        ),
                        if (_model.recentSearches.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.recentSearches,
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(),
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary80,
                                    ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: _model.recentSearches
                                      .map((search) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _model.fromLocation =
                                                      search['from']!;
                                                  _model.toLocation =
                                                      search['to']!;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .onPrimary10,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  '${search['from']!.split(',').first} → ${search['to']!.split(',').first}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.inter(),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .onPrimary,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ].divide(const SizedBox(height: 8)),
                          ),
                        const SizedBox(height: 16),
                        WalletSummary(
                          balance: _model.walletBalance,
                          rewardPoints: _model.rewardPoints,
                          onTap: () => context.pushNamed('Wallet'),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Continue Planning
              if (_model.recentlyViewed.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          FlutterFlowTheme.of(context).designToken.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continue Planning',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold),
                            ),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _model.recentlyViewed.map((item) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Container(
                              width: 280,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image']!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.plusJakartaSans(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                        ),
                                        Text(
                                          item['subtitle']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context).bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                ],
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.popularRoutes,
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  lineHeight: 1.45,
                                ),
                          ),
                          InkWell(
                            onTap: () async {
                              context.pushNamed(AllRoutesWidget.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.seeAll,
                              style: FlutterFlowTheme.of(context).labelLarge.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.popularRouteItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PopularRouteItemWidget(
                                    imgDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/Lokhandwala%20Complex%20Mumbai',
                                    price: '499',
                                    route: 'Mumbai to Pune',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.popularRouteItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PopularRouteItemWidget(
                                    imgDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/Sula%20Vineyards%20Nashik',
                                    price: '350',
                                    route: 'Pune to Nashik',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.popularRouteItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PopularRouteItemWidget(
                                    imgDesc: 'https://dimg.dreamflow.cloud/v1/image/Dargah%20Ahmedabad',
                                    price: '550',
                                    route: 'Ahmedabad to Surat',
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              // Popular Destinations
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Destinations',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold),
                              ),
                        ),
                        Text(
                          'See All',
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(),
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _model.popularDestinations
                            .map((dest) => Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: PremiumCardWidget(
                                    image: dest['image'],
                                    title: dest['title'],
                                    subtitle: dest['subtitle'],
                                    rating: dest['rating'],
                                    price: dest['price'],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Weekend Getaways
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekend Getaways',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _model.weekendGetaways
                            .map((dest) => Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: PremiumCardWidget(
                                    image: dest['image'],
                                    title: dest['title'],
                                    subtitle: dest['subtitle'],
                                    rating: dest['rating'],
                                    price: dest['price'],
                                    width: 250,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    FlutterFlowTheme.of(context).designToken.spacing.lg,
                    0.0,
                    FlutterFlowTheme.of(context).designToken.spacing.lg,
                    FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.specialOffers,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                            ),
                            fontWeight: FontWeight.bold,
                            lineHeight: 1.45,
                          ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20bus%20interior',
                          ),
                        ),
                        borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).fullContrast67,
                              Colors.transparent
                            ],
                            stops: const [0.0, 1.0],
                            begin: const AlignmentDirectional(-1.0, 0.0),
                            end: const AlignmentDirectional(1.0, 0),
                          ),
                          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                  child: Text(
                                    'FLASHPRO',
                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          color: FlutterFlowTheme.of(context).onSurface,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                'Get 20% Off',
                                style: FlutterFlowTheme.of(context).headlineSmall.override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: FlutterFlowTheme.of(context).onSurface,
                                    ),
                              ),
                              Text(
                                'On your first booking',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(),
                                      color: FlutterFlowTheme.of(context).onSurface,
                                    ),
                              ),
                              const SizedBox(height: 12.0),
                              wrapWithModel(
                                model: _model.buttonModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  iconPresent: false,
                                  iconEndPresent: false,
                                  content: 'Book Now',
                                  variant: 'primary',
                                  size: 'small',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: false,
                                  onTap: () {
                                    safeSetState(() {
                                      _model.fromLocation = 'Mumbai, Maharashtra';
                                      _model.toLocation = 'Pune, Maharashtra';
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Special Offer Applied: Mumbai to Pune')),
                                    );
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(height: 4.0)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              // Nearby Places
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nearby Places',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _model.nearbyPlaces
                            .map((place) => Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: PremiumCardWidget(
                                    image: place['image'],
                                    title: place['title'],
                                    subtitle: place['subtitle'],
                                    rating: place['rating'],
                                    width: 180,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Recommendations
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended for You',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _model.recommendations.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final rec = _model.recommendations[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  rec['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rec['title'],
                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                            font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold),
                                          ),
                                    ),
                                    Text(
                                      rec['subtitle'],
                                      style: FlutterFlowTheme.of(context).bodySmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      rec['price'],
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(),
                                            color: FlutterFlowTheme.of(context).primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star_rounded,
                                          color: FlutterFlowTheme.of(context).warning, size: 16),
                                      Text(
                                        rec['rating'].toString(),
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                              font: GoogleFonts.inter(),
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(Icons.arrow_forward_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
