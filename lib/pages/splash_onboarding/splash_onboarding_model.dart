import '/components/button/button_widget.dart';
import '/components/onboarding_step/onboarding_step_widget.dart';
import '/components/step_indicator/step_indicator_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'splash_onboarding_widget.dart' show SplashOnboardingWidget;
import 'package:flutter/material.dart';

class SplashOnboardingModel extends FlutterFlowModel<SplashOnboardingWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  // Model for OnboardingStep.
  late OnboardingStepModel onboardingStepModel1;
  late OnboardingStepModel onboardingStepModel2;
  late OnboardingStepModel onboardingStepModel3;
  // Model for StepIndicator.
  late StepIndicatorModel stepIndicatorModel1;
  // Model for StepIndicator.
  late StepIndicatorModel stepIndicatorModel2;
  // Model for StepIndicator.
  late StepIndicatorModel stepIndicatorModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    onboardingStepModel1 = createModel(context, () => OnboardingStepModel());
    onboardingStepModel2 = createModel(context, () => OnboardingStepModel());
    onboardingStepModel3 = createModel(context, () => OnboardingStepModel());
    stepIndicatorModel1 = createModel(context, () => StepIndicatorModel());
    stepIndicatorModel2 = createModel(context, () => StepIndicatorModel());
    stepIndicatorModel3 = createModel(context, () => StepIndicatorModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    onboardingStepModel1.dispose();
    onboardingStepModel2.dispose();
    onboardingStepModel3.dispose();
    stepIndicatorModel1.dispose();
    stepIndicatorModel2.dispose();
    stepIndicatorModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
