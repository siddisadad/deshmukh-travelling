import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_legend_item_model.dart';
export 'seat_legend_item_model.dart';

class SeatLegendItemWidget extends StatefulWidget {
  const SeatLegendItemWidget({
    super.key,
    Color? color,
    String? label,
  })  : this.color = color ?? const Color(0x00000000),
        this.label = label ?? 'Available';

  final Color color;
  final String label;

  @override
  State<SeatLegendItemWidget> createState() => _SeatLegendItemWidgetState();
}

class _SeatLegendItemWidgetState extends State<SeatLegendItemWidget> {
  late SeatLegendItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeatLegendItemModel());

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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget.color,
              FlutterFlowTheme.of(context).primaryBackground,
            ),
            borderRadius: BorderRadius.circular(4.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
        ),
        Text(
          valueOrDefault<String>(
            widget.label,
            'Available',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
