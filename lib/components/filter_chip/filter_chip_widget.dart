import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_chip_model.dart';
export 'filter_chip_model.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({
    super.key,
    this.icon,
    bool? iconPresent,
    String? label,
    bool? selected,
  })  : this.iconPresent = iconPresent ?? true,
        this.label = label ?? 'All',
        this.selected = selected ?? true;

  final Widget? icon;
  final bool iconPresent;
  final String label;
  final bool selected;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  late FilterChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterChipModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget.selected,
                true,
              )
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).secondaryBackground,
              FlutterFlowTheme.of(context).primary,
            ),
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: valueOrDefault<Color>(
                valueOrDefault<bool>(
                  widget.selected,
                  true,
                )
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).alternate,
                FlutterFlowTheme.of(context).primary,
              ),
              width: valueOrDefault<double>(
                valueOrDefault<bool>(
                  widget.selected,
                  true,
                )
                    ? 1.0
                    : 1.0,
                1.0,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (valueOrDefault<bool>(
                    widget.iconPresent,
                    true,
                  ))
                    widget.icon!,
                  Text(
                    valueOrDefault<String>(
                      widget.label,
                      'All',
                    ),
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                          ),
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget.selected,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).onPrimary
                                : FlutterFlowTheme.of(context).primaryText,
                            FlutterFlowTheme.of(context).onPrimary,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                ].divide(SizedBox(width: 4.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
