import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_step_model.dart';
export 'onboarding_step_model.dart';

class OnboardingStepWidget extends StatefulWidget {
  const OnboardingStepWidget({
    super.key,
    String? description,
    String? imgDesc,
    String? title,
  })  : this.description = description ??
            'Experience premium journeys with our fleet of high-end, air-conditioned buses designed for maximum relaxation.',
        this.imgDesc = imgDesc ??
            'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20coach%20bus%20interior%20with%20comfortable%20seats',
        this.title = title ?? 'Travel in Comfort';

  final String description;
  final String imgDesc;
  final String title;

  @override
  State<OnboardingStepWidget> createState() => _OnboardingStepWidgetState();
}

class _OnboardingStepWidgetState extends State<OnboardingStepWidget> {
  late OnboardingStepModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingStepModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Container(
            width: 320.0,
            height: 320.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
            ),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 0),
              fadeOutDuration: const Duration(milliseconds: 0),
              imageUrl: valueOrDefault<String>(
                widget.imgDesc,
                'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20coach%20bus%20interior%20with%20comfortable%20seats',
              ),
              fit: BoxFit.cover,
              alignment: const Alignment(0.0, 0.0),
              errorWidget: (context, url, error) => Container(
                color: FlutterFlowTheme.of(context).alternate,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget.title,
                  'Travel in Comfort',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      lineHeight: 1.3,
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  widget.description,
                  'Experience premium journeys with our fleet of high-end, air-conditioned buses designed for maximum relaxation.',
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      lineHeight: 1.5,
                    ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ].divide(SizedBox(height: 24.0)),
    );
  }
}
