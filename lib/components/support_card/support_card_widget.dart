import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'support_card_model.dart';
export 'support_card_model.dart';

class SupportCardWidget extends StatefulWidget {
  const SupportCardWidget({
    super.key,
    Color? bgLight,
    Color? color,
    this.icon,
    String? label,
  })  : this.bgLight = bgLight ?? const Color(0xFFE8F5E9),
        this.color = color ?? const Color(0xFF25D366),
        this.label = label ?? 'WhatsApp';

  final Color bgLight;
  final Color color;
  final Widget? icon;
  final String label;

  @override
  State<SupportCardWidget> createState() => _SupportCardWidgetState();
}

class _SupportCardWidgetState extends State<SupportCardWidget> {
  late SupportCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.all(24.0),
        child: Container(
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget.bgLight,
                      Color(0xFFE8F5E9),
                    ),
                    borderRadius: BorderRadius.circular(9999.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: widget.icon!,
                ),
                Text(
                  valueOrDefault<String>(
                    widget.label,
                    'WhatsApp',
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        lineHeight: 1.4,
                      ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
