import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'price_summary_row_model.dart';
export 'price_summary_row_model.dart';

class PriceSummaryRowWidget extends StatefulWidget {
  const PriceSummaryRowWidget({
    super.key,
    Color? color,
    String? isTotal,
    String? label,
    String? value,
  })  : this.color = color ?? const Color(0x00000000),
        this.isTotal = isTotal ?? 'true',
        this.label = label ?? 'Base Fare',
        this.value = value ?? '₹1,200';

  final Color color;
  final String isTotal;
  final String label;
  final String value;

  @override
  State<PriceSummaryRowWidget> createState() => _PriceSummaryRowWidgetState();
}

class _PriceSummaryRowWidgetState extends State<PriceSummaryRowWidget> {
  late PriceSummaryRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PriceSummaryRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Base Fare',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  valueOrDefault<String>(
                            widget.isTotal,
                            'true',
                          ) ==
                          'true'
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).secondaryText,
                  FlutterFlowTheme.of(context).primaryText,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.5,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget.value,
            '₹1,200',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  valueOrDefault<String>(
                            widget.isTotal,
                            'true',
                          ) ==
                          'true'
                      ? FlutterFlowTheme.of(context).primaryText
                      : Color(0x00000000),
                  FlutterFlowTheme.of(context).primaryText,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.5,
              ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
