import 'components/passenger_form_list.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/booking_record.dart';
import '/components/button/button_widget.dart';
import '/components/passenger_form/passenger_form_widget.dart';
import '/components/section_header_a8889900/section_header_a8889900_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'passenger_details_model.dart';
export 'passenger_details_model.dart';

class PassengerDetailsWidget extends StatefulWidget {
  const PassengerDetailsWidget({
    super.key,
    this.selectedSeats,
    this.bus,
  });

  final List<String>? selectedSeats;
  final BusRecord? bus;

  static String routeName = 'PassengerDetails';
  static String routePath = '/passengerDetails';

  @override
  State<PassengerDetailsWidget> createState() => _PassengerDetailsWidgetState();
}

class _PassengerDetailsWidgetState extends State<PassengerDetailsWidget> {
  late PassengerDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PassengerDetailsModel());

    // Initialize forms based on selected seats
    final numSeats = widget.selectedSeats?.length ?? 1;
    _model.passengerFormModels = List.generate(
      numSeats,
      (index) => createModel(context, () => PassengerFormModel()),
    );

    _prefillContactInfo();

    _model.textFieldModel1.inputTextControllerValidator = (context, val) {
      if (val == null || val.isEmpty) return 'Please enter a mobile number';
      if (val.length != 10) return 'Enter a valid 10-digit number';
      return null;
    };
    _model.textFieldModel2.inputTextControllerValidator = (context, val) {
      if (val == null || val.isEmpty) return 'Please enter an email';
      if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) return 'Invalid email';
      return null;
    };

    // Set validators for each passenger form
    for (var m in _model.passengerFormModels) {
      m.textFieldModel1.inputTextControllerValidator = (context, val) {
        if (val == null || val.isEmpty) return 'Full name required';
        return null;
      };
      m.textFieldModel2.inputTextControllerValidator = (context, val) {
        if (val == null || val.isEmpty) return 'Age required';
        if (int.tryParse(val) == null) return 'Invalid age';
        return null;
      };
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _prefillContactInfo() async {
    final user = await _model.firestoreService.getUser(currentUserUid);
    if (user != null) {
      safeSetState(() {
        _model.textFieldModel1.inputTextController?.text = user.phoneNumber ?? '';
        _model.textFieldModel2.inputTextController?.text = user.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();
    for (var m in _model.passengerFormModels) {
      m.dispose();
    }

    super.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final passengers = _model.passengerFormModels.map((m) {
      return Passenger(
        name: m.name,
        age: m.age,
        gender: m.gender,
      );
    }).toList();

    final booking = BookingRecord(
      userId: currentUserUid,
      busId: widget.bus?.id ?? 'bus123',
      busName: widget.bus?.name ?? 'Deshmukh Luxury',
      busType: widget.bus?.type ?? 'AC • Sleeper',
      departureCity: widget.bus?.departureCity ?? 'Mumbai',
      arrivalCity: widget.bus?.arrivalCity ?? 'Pune',
      depTime: widget.bus?.depTime ?? '08:30 PM',
      arrTime: widget.bus?.arrTime ?? '06:00 AM',
      seatNumbers: widget.selectedSeats ?? ['S-1'],
      passengers: passengers,
      totalAmount: (widget.bus?.price ?? 850) * (widget.selectedSeats?.length ?? 1) * 1.05 + 50,
      status: 'confirmed',
      timestamp: DateTime.now(),
    );

    context.goNamed(
      PaymentCheckoutWidget.routeName,
      queryParameters: {
        'booking': serializeParam(booking.toMap(), ParamType.JSON),
      }.withoutNulls,
    );
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: FlutterFlowTheme.of(context).designToken.spacing.lg,
                        vertical: FlutterFlowTheme.of(context).designToken.spacing.md),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.goNamed(SeatSelectionWidget.routeName);
                            },
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.passengerDetails,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.info_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary10,
                                            borderRadius:
                                                BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.sm),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.directions_bus_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            size: 24.0,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${widget.bus?.departureCity.split(',').first ?? 'Mumbai'} → ${widget.bus?.arrivalCity.split(',').first ?? 'Pune'}',
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.5,
                                                        ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Oct 28, 2023 • ${widget.bus?.depTime ?? '08:30 AM'}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                      lineHeight: 1.6,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '₹${((widget.bus?.price ?? 850) * (widget.selectedSeats?.length ?? 1)).toInt()}',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    font: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                    lineHeight: 1.45,
                                                  ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.totalAmount,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              PassengerFormList(
                                model: _model,
                                onUpdate: () => safeSetState(() {}),
                              ),
                              wrapWithModel(
                                model: _model.sectionHeaderA8889900Model2,
                                updateCallback: () => safeSetState(() {}),
                                child: SectionHeaderA8889900Widget(
                                  hasSubtitle: true,
                                  subtitle: 'Booking QR code will be sent here',
                                  title: 'Contact Information',
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        wrapWithModel(
                                          model: _model.textFieldModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'Mobile Number',
                                            labelPresent: true,
                                            helper: '',
                                            helperPresent: false,
                                            leadingIcon: Icon(
                                              Icons.phone_android_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            leadingIconPresent: true,
                                            trailingIconPresent: false,
                                            hint: '10-digit mobile number',
                                            value: '',
                                            onChange: '',
                                            onSubmit: '',
                                            variant: 'outlined',
                                            error: false,
                                            controller: _model.textFieldModel1.inputTextController,
                                            focusNode: _model.textFieldModel1.inputFocusNode,
                                            keyboardType: TextInputType.phone,
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.textFieldModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'Email Address',
                                            labelPresent: true,
                                            helper: '',
                                            helperPresent: false,
                                            leadingIcon: Icon(
                                              Icons.email_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                            leadingIconPresent: true,
                                            trailingIconPresent: false,
                                            hint: 'example@mail.com',
                                            value: '',
                                            onChange: '',
                                            onSubmit: '',
                                            variant: 'outlined',
                                            error: false,
                                            controller: _model.textFieldModel2.inputTextController,
                                            focusNode: _model.textFieldModel2.inputFocusNode,
                                            keyboardType: TextInputType.emailAddress,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Color(0xFFBBDEFB),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.verified_user_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Secure Booking',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelLarge
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontStyle,
                                                      lineHeight: 1.4,
                                                    ),
                                              ),
                                              Text(
                                                'Your data is encrypted and handled securely by Deshmukh Technologies LLP.',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary80,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                      lineHeight: 1.6,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100.0,
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                height: 110.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Container(
                          height: 61.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹${((widget.bus?.price ?? 850) * (widget.selectedSeats?.length ?? 1) * 1.05 + 50).toInt()}', // Price + Fees + Taxes
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.selectedSeats?.length ?? 1} Passengers',
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                      Text(
                                        '•',
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                      Text(
                                        'Inc. taxes',
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _onContinue();
                                  },
                                  child: wrapWithModel(
                                    model: _model.buttonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      iconPresent: false,
                                      iconEnd: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      iconEndPresent: true,
                                      content: AppLocalizations.of(context)!.proceedToPayment,
                                      variant: 'primary',
                                      size: 'large',
                                      fullWidth: false,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 24.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
