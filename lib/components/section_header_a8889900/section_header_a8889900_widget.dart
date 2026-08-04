import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header_a8889900_model.dart';
export 'section_header_a8889900_model.dart';

class SectionHeaderA8889900Widget extends StatefulWidget {
  const SectionHeaderA8889900Widget({
    super.key,
    bool? hasSubtitle,
    String? subtitle,
    String? title,
  })  : this.hasSubtitle = hasSubtitle ?? true,
        this.subtitle = subtitle ?? 'Enter details for all selected seats',
        this.title = title ?? 'Passenger Info';

  final bool hasSubtitle;
  final String subtitle;
  final String title;

  @override
  State<SectionHeaderA8889900Widget> createState() =>
      _SectionHeaderA8889900WidgetState();
}

class _SectionHeaderA8889900WidgetState
    extends State<SectionHeaderA8889900Widget> {
  late SectionHeaderA8889900Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionHeaderA8889900Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valueOrDefault<String>(
                widget.title,
                'Passenger Info',
              ),
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    lineHeight: 1.45,
                  ),
            ),
            if (valueOrDefault<bool>(
              widget.hasSubtitle,
              true,
            ))
              Text(
                valueOrDefault<String>(
                  widget.subtitle,
                  'Enter details for all selected seats',
                ),
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      lineHeight: 1.6,
                    ),
              ),
          ].divide(SizedBox(height: 4.0)),
        ),
      ),
    );
  }
}
