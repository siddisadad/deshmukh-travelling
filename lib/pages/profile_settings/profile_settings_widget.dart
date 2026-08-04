import '/components/button/button_widget.dart';
import '/components/passenger_card/passenger_card_widget.dart';
import '/components/profile_menu_item/profile_menu_item_widget.dart';
import '/components/support_card/support_card_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_settings_model.dart';
export 'profile_settings_model.dart';

class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({super.key});

  static String routeName = 'ProfileSettings';
  static String routePath = '/profileSettings';

  @override
  State<ProfileSettingsWidget> createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget> {
  late ProfileSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSettingsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional(-1.0, -1.0),
                children: [
                  Container(
                    height: 220.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary,
                          FlutterFlowTheme.of(context).secondary
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              fillColor: Colors.transparent,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            Text(
                              'Profile',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).onSurface,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              fillColor: Colors.transparent,
                              icon: Icon(
                                Icons.edit_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 20.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(9999.0),
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9999.0),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              width: 3.0,
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 0),
                                            fadeOutDuration:
                                                Duration(milliseconds: 0),
                                            imageUrl:
                                                'https://dimg.dreamflow.cloud/v1/image/professional%20portrait%20of%20an%20Indian%20man',
                                            fit: BoxFit.cover,
                                            alignment: Alignment(0.0, 0.0),
                                          ),
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
                                              'Aditya Deshmukh',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                    lineHeight: 1.35,
                                                  ),
                                            ),
                                            Text(
                                              '+91 98765 43210',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .onSurface,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                              child: Container(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE3F2FD),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9999.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 4.0,
                                                                12.0, 4.0),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .verified_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .onSurface,
                                                            size: 14.0,
                                                          ),
                                                          Text(
                                                            'Verified Traveler',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelSmall
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .onSurface,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.4,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 4.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 24.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Saved Passengers',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                                lineHeight: 1.45,
                              ),
                        ),
                        wrapWithModel(
                          model: _model.buttonModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: ButtonWidget(
                            icon: Icon(
                              Icons.add_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            iconPresent: true,
                            iconEndPresent: false,
                            content: 'Add New',
                            variant: 'ghost',
                            size: 'small',
                            fullWidth: false,
                            loading: false,
                            disabled: false,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 12.0),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.passengerCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PassengerCardWidget(
                                      initials: 'AD',
                                      name: 'Aditya Deshmukh',
                                      relation: 'Self',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.passengerCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PassengerCardWidget(
                                      initials: 'SD',
                                      name: 'Sunita Deshmukh',
                                      relation: 'Spouse',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.passengerCardModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PassengerCardWidget(
                                      initials: 'MD',
                                      name: 'Manoj Deshmukh',
                                      relation: 'Father',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Account Settings',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.45,
                          ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.person_outline_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'Manage your data and identity',
                        title: 'Personal Information',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.history_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'View all your past trips',
                        title: 'Booking History',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'Manage alerts and offers',
                        title: 'Notifications',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'Manage methods and refunds',
                        title: 'Payments & Wallet',
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Preferences',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.45,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.dark_mode_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      size: 22.0,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dark Mode',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                      Text(
                                        'Switch to night theme',
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
                                                      .onSurface,
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
                                    ],
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              wrapWithModel(
                                model: _model.switchModel,
                                updateCallback: () => safeSetState(() {}),
                                child: SwitchComponentWidget(
                                  label: '',
                                  labelPresent: false,
                                  variant: 'iOS',
                                  active: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel5,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.language_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'English (US)',
                        title: 'Language',
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Support & Legal',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.45,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.supportCardModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: SupportCardWidget(
                              bgLight: Color(0xFFE8F5E9),
                              color: Color(0xFF25D366),
                              icon: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: Color(0xFF25D366),
                                size: 24.0,
                              ),
                              label: 'WhatsApp',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.supportCardModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: SupportCardWidget(
                              bgLight: Color(0xFFE3F2FD),
                              color: FlutterFlowTheme.of(context).primary,
                              icon: Icon(
                                Icons.help_outline_rounded,
                                color: Color(0xFF25D366),
                                size: 24.0,
                              ),
                              label: 'FAQ',
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel6,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.description_outlined,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'How we handle your data',
                        title: 'Privacy Policy',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.profileMenuItemModel7,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileMenuItemWidget(
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        subtitle: 'Version 1.0.0',
                        title: 'About Deshmukh Travelling',
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 32.0),
                  child: Container(
                    child: wrapWithModel(
                      model: _model.buttonModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.logout_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: 'Logout',
                        variant: 'destructive',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
