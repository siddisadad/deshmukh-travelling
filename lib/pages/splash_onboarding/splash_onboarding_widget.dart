import '/components/button/button_widget.dart';
import '/components/onboarding_step/onboarding_step_widget.dart';
import '/components/step_indicator/step_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_onboarding_model.dart';
export 'splash_onboarding_model.dart';

class SplashOnboardingWidget extends StatefulWidget {
  const SplashOnboardingWidget({super.key});

  static String routeName = 'SplashOnboarding';
  static String routePath = '/splashOnboarding';

  @override
  State<SplashOnboardingWidget> createState() => _SplashOnboardingWidgetState();
}

class _SplashOnboardingWidgetState extends State<SplashOnboardingWidget> {
  late SplashOnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashOnboardingModel());

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
        body: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            Align(
              alignment: AlignmentDirectional(-1.2, -0.8),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary5,
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 32.0, 24.0, 32.0),
                      child: Container(
                        child: Container(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Icon(
                                      Icons.directions_bus_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Deshmukh Travelling',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.onboardingStepModel,
                    updateCallback: () => safeSetState(() {}),
                    child: OnboardingStepWidget(
                      description:
                          'Experience premium journeys with our fleet of high-end, air-conditioned buses designed for maximum relaxation.',
                      imgDesc:
                          'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20coach%20bus%20interior%20with%20comfortable%20seats',
                      title: 'Travel in Comfort',
                    ),
                  ),
                  Container(
                    height: 32.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.stepIndicatorModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: StepIndicatorWidget(
                                active: true,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.stepIndicatorModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: StepIndicatorWidget(
                                active: false,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.stepIndicatorModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: StepIndicatorWidget(
                                active: false,
                              ),
                            ),
                          ].divide(SizedBox(width: 4.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.goNamed(HomeDashboardWidget.routeName);
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  iconPresent: false,
                                  iconEndPresent: false,
                                  content: 'Get Started',
                                  variant: 'primary',
                                  size: 'large',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.goNamed(HomeDashboardWidget.routeName);
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  iconPresent: false,
                                  iconEndPresent: false,
                                  content: 'Sign In to Account',
                                  variant: 'ghost',
                                  size: 'medium',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ].divide(SizedBox(height: 32.0)),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Container(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Powered by',
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
                                'Deshmukh Technologies LLP',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
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
            Container(
              width: 0.0,
              height: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
