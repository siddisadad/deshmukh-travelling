import '/components/button/button_widget.dart';
import '/components/onboarding_step/onboarding_step_widget.dart';
import '/components/step_indicator/step_indicator_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'splash_onboarding_widget.dart' show SplashOnboardingWidget;
import 'package:flutter/material.dart';

class SplashOnboardingModel extends FlutterFlowModel<SplashOnboardingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for OnboardingStep.
  late OnboardingStepModel onboardingStepModel;
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
    onboardingStepModel = createModel(context, () => OnboardingStepModel());
    stepIndicatorModel1 = createModel(context, () => StepIndicatorModel());
    stepIndicatorModel2 = createModel(context, () => StepIndicatorModel());
    stepIndicatorModel3 = createModel(context, () => StepIndicatorModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    onboardingStepModel.dispose();
    stepIndicatorModel1.dispose();
    stepIndicatorModel2.dispose();
    stepIndicatorModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
