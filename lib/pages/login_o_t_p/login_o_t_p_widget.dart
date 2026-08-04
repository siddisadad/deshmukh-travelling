import '/pages/home_dashboard/home_dashboard_widget.dart';
import '/pages/signup/signup_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/button/button_widget.dart';
import '/components/feature_item/feature_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';
import 'login_o_t_p_model.dart';
export 'login_o_t_p_model.dart';

class LoginOTPWidget extends StatefulWidget {
  const LoginOTPWidget({super.key});

  static String routeName = 'LoginOTP';
  static String routePath = '/loginOTP';

  @override
  State<LoginOTPWidget> createState() => _LoginOTPWidgetState();
}

class _LoginOTPWidgetState extends State<LoginOTPWidget> {
  late LoginOTPModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginOTPModel());

    authManager.handlePhoneAuthStateChanges(context);

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
          primary: true,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 280.0,
                child: Stack(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                        bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                      ),
                      child: Container(
                        height: 280.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 0),
                          fadeOutDuration: Duration(milliseconds: 0),
                          imageUrl:
                              'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20travel%20bus%20on%20highway%20mountain%20background',
                          height: 280.0,
                          fit: BoxFit.cover,
                          alignment: Alignment(0.0, 0.0),
                        ),
                      ),
                    ),
                    Container(
                      height: 280.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary80,
                            FlutterFlowTheme.of(context).primary93
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                          bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).onPrimary,
                                borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                                shape: BoxShape.rectangle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.directions_bus_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 42.0,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.appTitle,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w900,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .onBackground,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                Text(
                                  'By Deshmukh Technologies LLP',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .onBackground,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _model.isOtpSent ? AppLocalizations.of(context)!.verifyOtp : AppLocalizations.of(context)!.welcomeBack,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                    lineHeight: 1.35,
                                  ),
                            ),
                            Text(
                              _model.isOtpSent
                                  ? 'Enter the 6-digit code sent to +91 ${_model.phoneNumber}'
                                  : (_model.isEmailLogin ? 'Login with your email and password' : AppLocalizations.of(context)!.enterPhone),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                        if (!_model.isOtpSent)
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => safeSetState(() => _model.isEmailLogin = false),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !_model.isEmailLogin ? FlutterFlowTheme.of(context).primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Phone',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                        color: !_model.isEmailLogin ? Colors.white : FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => safeSetState(() => _model.isEmailLogin = true),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _model.isEmailLogin ? FlutterFlowTheme.of(context).primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Email',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                        color: _model.isEmailLogin ? Colors.white : FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!_model.isEmailLogin)
                            Text(
                              _model.isOtpSent
                                  ? AppLocalizations.of(context)!.verifyOtp
                                  : AppLocalizations.of(context)!.phoneNumber,
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            if (!_model.isOtpSent && !_model.isEmailLogin)
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          fadeInDuration:
                                              Duration(milliseconds: 0),
                                          fadeOutDuration:
                                              Duration(milliseconds: 0),
                                          imageUrl:
                                              'https://dimg.dreamflow.cloud/v1/image/India%20flag%20icon',
                                          width: 24.0,
                                          height: 16.0,
                                          fit: BoxFit.contain,
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                        Text(
                                          '+91',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FlutterFlowTheme
                                                        .of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: '',
                                        labelPresent: false,
                                        helper: '',
                                        helperPresent: false,
                                        leadingIconPresent: false,
                                        trailingIconPresent: false,
                                        hint: '98765 43210',
                                        value: '',
                                        onChange: '',
                                        onSubmit: '',
                                        variant: 'filled',
                                        error: false,
                                        controller: _model.textFieldModel.inputTextController,
                                        focusNode: _model.textFieldModel.inputFocusNode,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            if (_model.isEmailLogin)
                              Column(
                                children: [
                                  wrapWithModel(
                                    model: _model.emailModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      label: AppLocalizations.of(context)!.emailAddress,
                                      hint: 'Enter your email',
                                      leadingIconPresent: true,
                                      leadingIcon: Icon(Icons.email_outlined, color: FlutterFlowTheme.of(context).primary),
                                      controller: _model.emailModel.inputTextController,
                                      focusNode: _model.emailModel.inputFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  wrapWithModel(
                                    model: _model.passwordModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      label: AppLocalizations.of(context)!.password,
                                      hint: 'Enter your password',
                                      leadingIconPresent: true,
                                      leadingIcon: Icon(Icons.lock_outline, color: FlutterFlowTheme.of(context).primary),
                                      obscureText: true,
                                      controller: _model.passwordModel.inputTextController,
                                      focusNode: _model.passwordModel.inputFocusNode,
                                    ),
                                  ),
                                ],
                              ),
                            if (_model.isOtpSent)
                              wrapWithModel(
                                model: _model.otpFieldModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: '',
                                  labelPresent: false,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIconPresent: true,
                                  leadingIcon: Icon(Icons.lock_outline_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20),
                                  trailingIconPresent: false,
                                  hint: 'Enter 6-digit OTP',
                                  value: '',
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'filled',
                                  error: false,
                                  controller: _model.otpFieldModel.inputTextController,
                                  focusNode: _model.otpFieldModel.inputFocusNode,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                        wrapWithModel(
                          model: _model.buttonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: ButtonWidget(
                            iconPresent: false,
                            iconEnd: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            iconEndPresent: true,
                            content: _model.isOtpSent
                                ? AppLocalizations.of(context)!.verifyOtp
                                : (_model.isEmailLogin ? AppLocalizations.of(context)!.login : AppLocalizations.of(context)!.sendOtp),
                            variant: 'primary',
                            size: 'large',
                            fullWidth: true,
                            loading: false,
                            disabled: false,
                            onTap: () async {
                              if (_model.isEmailLogin) {
                                final email = _model.emailModel.inputTextController.text;
                                final password = _model.passwordModel.inputTextController.text;
                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please enter email and password')),
                                  );
                                  return;
                                }
                                final user = await authManager.signInWithEmail(context, email, password);
                                if (user != null) {
                                  context.goNamed(HomeDashboardWidget.routeName);
                                }
                                return;
                              }

                              if (!_model.isOtpSent) {
                                final phoneVal =
                                    _model.textFieldModel.inputTextController?.text;
                                if (phoneVal == null || phoneVal.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter phone number'),
                                    ),
                                  );
                                  return;
                                }
                                final fullPhone = '+91$phoneVal';
                                await authManager.beginPhoneAuth(
                                  context: context,
                                  phoneNumber: fullPhone,
                                  onCodeSent: (context) {
                                    safeSetState(() {
                                      _model.isOtpSent = true;
                                      _model.phoneNumber = phoneVal;
                                    });
                                  },
                                );
                              } else {
                                final otpVal =
                                    _model.otpFieldModel.inputTextController?.text;
                                if (otpVal == null || otpVal.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter OTP'),
                                    ),
                                  );
                                  return;
                                }
                                final user = await authManager.verifySmsCode(
                                  context: context,
                                  smsCode: otpVal,
                                );
                                if (user != null) {
                                  final userDoc = await _model.firestoreService
                                      .getUser(user.uid);
                                  if (userDoc != null) {
                                    context.goNamed(
                                        HomeDashboardWidget.routeName);
                                  } else {
                                    context.goNamed(SignupWidget.routeName);
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        if (!_model.isOtpSent)
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .dontHaveAccount),
                                InkWell(
                                  onTap: () => context.pushNamed('Signup'),
                                  child: Text(
                                    AppLocalizations.of(context)!.signUp,
                                    style: TextStyle(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_model.isOtpSent)
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: InkWell(
                              onTap: () async {
                                safeSetState(() {
                                  _model.isOtpSent = false;
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!.changePhone,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      decoration: TextDecoration.underline,
                                      lineHeight: 1.6,
                                    ),
                              ),
                            ),
                          ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: FlutterFlowTheme.of(context).designToken.spacing.md),
                      child: Container(
                        child: Divider(
                          height: 16.0,
                          thickness: 1.0,
                          indent: 0.0,
                          endIndent: 0.0,
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wrapWithModel(
                          model: _model.featureItemModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: FeatureItemWidget(
                            desc: AppLocalizations.of(context)!
                                .verifiedOperators,
                            icon: Icon(
                              Icons.shield_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            title: AppLocalizations.of(context)!.safeTravel,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.featureItemModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: FeatureItemWidget(
                            desc: AppLocalizations.of(context)!
                                .encryptedTransactions,
                            icon: Icon(
                              Icons.payments_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            title: AppLocalizations.of(context)!.securePayments,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.featureItemModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: FeatureItemWidget(
                            desc: AppLocalizations.of(context)!.alwaysReadyHelp,
                            icon: Icon(
                              Icons.support_agent_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            title: AppLocalizations.of(context)!.support247,
                          ),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                  child: Container(
                    child: Container(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.agreeTerms,
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).onBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.termsOfService,
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                '&',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .onBackground,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.privacyPolicy,
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(width: 4.0)),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
