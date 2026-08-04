import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_widget_model.dart';
export 'seat_widget_model.dart';

class SeatWidgetWidget extends StatefulWidget {
  const SeatWidgetWidget({
    super.key,
    String? number,
    String? status,
  })  : this.number = number ?? '1',
        this.status = status ?? 'booked';

  final String number;
  final String status;

  @override
  State<SeatWidgetWidget> createState() => _SeatWidgetWidgetState();
}

class _SeatWidgetWidgetState extends State<SeatWidgetWidget> {
  late SeatWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeatWidgetModel());

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
      width: 48.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: () {
          if (widget.status == 'selected') {
            return FlutterFlowTheme.of(context).primary;
          }
          if (widget.status == 'booked') {
            return FlutterFlowTheme.of(context).surfaceVariant;
          }
          return FlutterFlowTheme.of(context).primaryBackground;
        }(),
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            valueOrDefault<String>(
              widget.number,
              '1',
            ),
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: () {
                    if (widget.status == 'selected') {
                      return FlutterFlowTheme.of(context).onPrimary;
                    }
                    if (widget.status == 'booked') {
                      return FlutterFlowTheme.of(context).secondaryText;
                    }
                    return FlutterFlowTheme.of(context).primaryText;
                  }(),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  lineHeight: 1.4,
                ),
          ),
          Icon(
            Icons.event_seat_rounded,
            color: () {
              if (widget.status == 'selected') {
                return FlutterFlowTheme.of(context).onPrimary;
              }
              if (widget.status == 'booked') {
                return FlutterFlowTheme.of(context).secondaryText;
              }
              return FlutterFlowTheme.of(context).primary;
            }(),
            size: 14.0,
          ),
        ].divide(SizedBox(height: 2.0)),
      ),
    );
  }
}
