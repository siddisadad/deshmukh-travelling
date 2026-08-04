import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'button_model.dart';
export 'button_model.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.icon,
    bool? iconPresent,
    this.iconEnd,
    bool? iconEndPresent,
    String? content,
    String? variant,
    String? size,
    bool? fullWidth,
    bool? loading,
    bool? disabled,
    this.onTap,
  })  : this.iconPresent = iconPresent ?? false,
        this.iconEndPresent = iconEndPresent ?? false,
        this.content = content ?? 'Get Started',
        this.variant = variant ?? 'primary',
        this.size = size ?? 'large',
        this.fullWidth = fullWidth ?? false,
        this.loading = loading ?? false,
        this.disabled = disabled ?? false;

  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String content;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final VoidCallback? onTap;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late ButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled || widget.loading ? null : widget.onTap,
      child: Opacity(
        opacity: valueOrDefault<double>(
          valueOrDefault<bool>(
            widget.disabled,
            false,
          )
              ? 0.55
              : 1.0,
          1.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              () {
                if (valueOrDefault<String>(
                      widget.variant,
                      'primary',
                    ) ==
                    'secondary') {
                  return FlutterFlowTheme.of(context).secondary;
                } else if (valueOrDefault<String>(
                      widget.variant,
                      'primary',
                    ) ==
                    'outline') {
                  return Colors.transparent;
                } else if (valueOrDefault<String>(
                      widget.variant,
                      'primary',
                    ) ==
                    'ghost') {
                  return Colors.transparent;
                } else if (valueOrDefault<String>(
                      widget.variant,
                      'primary',
                    ) ==
                    'destructive') {
                  return FlutterFlowTheme.of(context).error;
                } else {
                  return FlutterFlowTheme.of(context).primary;
                }
              }(),
              FlutterFlowTheme.of(context).primary,
            ),
            borderRadius: BorderRadius.circular(
              () {
                if (valueOrDefault<String>(
                      widget.size,
                      'large',
                    ) ==
                    'small') {
                  return FlutterFlowTheme.of(context).designToken.radius.sm;
                } else if (valueOrDefault<String>(
                      widget.size,
                      'large',
                    ) ==
                    'large') {
                  return FlutterFlowTheme.of(context).designToken.radius.lg;
                } else {
                  return FlutterFlowTheme.of(context).designToken.radius.md;
                }
              }(),
            ),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: valueOrDefault<Color>(
                valueOrDefault<String>(
                          widget.variant,
                          'primary',
                        ) ==
                        'outline'
                    ? FlutterFlowTheme.of(context).alternate
                    : Colors.transparent,
                Colors.transparent,
              ),
              width: valueOrDefault<double>(
                valueOrDefault<String>(
                          widget.variant,
                          'primary',
                        ) ==
                        'outline'
                    ? 1.0
                    : 0.0,
                0.0,
              ),
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional(0.0, 0.0),
            children: [
              Opacity(
                opacity: valueOrDefault<double>(
                  valueOrDefault<bool>(
                    widget.loading,
                    false,
                  )
                      ? 0.0
                      : 1.0,
                  1.0,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                  horizontal: () {
                    if (valueOrDefault<String>(
                          widget.size,
                          'large',
                        ) ==
                        'small') {
                      return FlutterFlowTheme.of(context).designToken.spacing.md;
                    } else if (valueOrDefault<String>(
                          widget.size,
                          'large',
                        ) ==
                        'large') {
                      return FlutterFlowTheme.of(context).designToken.spacing.xl;
                    } else {
                      return FlutterFlowTheme.of(context).designToken.spacing.lg;
                    }
                  }(),
                  vertical: () {
                    if (valueOrDefault<String>(
                          widget.size,
                          'large',
                        ) ==
                        'small') {
                      return FlutterFlowTheme.of(context).designToken.spacing.xs;
                    } else if (valueOrDefault<String>(
                          widget.size,
                          'large',
                        ) ==
                        'large') {
                      return FlutterFlowTheme.of(context).designToken.spacing.md;
                    } else {
                      return FlutterFlowTheme.of(context).designToken.spacing.sm;
                    }
                  }(),
                ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (valueOrDefault<bool>(
                        widget.iconPresent,
                        false,
                      ))
                        widget.icon!,
                      Text(
                        valueOrDefault<String>(
                          widget.content,
                          'Get Started',
                        ),
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: valueOrDefault<Color>(
                                () {
                                  if (valueOrDefault<String>(
                                        widget.variant,
                                        'primary',
                                      ) ==
                                      'secondary') {
                                    return FlutterFlowTheme.of(context)
                                        .onSecondary;
                                  } else if (valueOrDefault<String>(
                                        widget.variant,
                                        'primary',
                                      ) ==
                                      'outline') {
                                    return FlutterFlowTheme.of(context)
                                        .primaryText;
                                  } else if (valueOrDefault<String>(
                                        widget.variant,
                                        'primary',
                                      ) ==
                                      'ghost') {
                                    return FlutterFlowTheme.of(context).primary;
                                  } else if (valueOrDefault<String>(
                                        widget.variant,
                                        'primary',
                                      ) ==
                                      'destructive') {
                                    return FlutterFlowTheme.of(context).onError;
                                  } else {
                                    return FlutterFlowTheme.of(context).onPrimary;
                                  }
                                }(),
                                FlutterFlowTheme.of(context).onPrimary,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                        overflow: TextOverflow.clip,
                      ),
                      if (valueOrDefault<bool>(
                        widget.iconEndPresent,
                        false,
                      ))
                        widget.iconEnd!,
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
              ),
              if (valueOrDefault<bool>(
                valueOrDefault<bool>(
                  widget.loading,
                  false,
                )
                    ? true
                    : false,
                false,
              ))
                CircularPercentIndicator(
                  percent: 0.0,
                  radius: 7.0,
                  lineWidth: 2.0,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: valueOrDefault<Color>(
                    () {
                      if (valueOrDefault<String>(
                            widget.variant,
                            'primary',
                          ) ==
                          'secondary') {
                        return FlutterFlowTheme.of(context).onSecondary;
                      } else if (valueOrDefault<String>(
                            widget.variant,
                            'primary',
                          ) ==
                          'outline') {
                        return FlutterFlowTheme.of(context).primaryText;
                      } else if (valueOrDefault<String>(
                            widget.variant,
                            'primary',
                          ) ==
                          'ghost') {
                        return FlutterFlowTheme.of(context).primary;
                      } else if (valueOrDefault<String>(
                            widget.variant,
                            'primary',
                          ) ==
                          'destructive') {
                        return FlutterFlowTheme.of(context).onError;
                      } else {
                        return FlutterFlowTheme.of(context).onPrimary;
                      }
                    }(),
                    FlutterFlowTheme.of(context).onPrimary,
                  ),
                  backgroundColor: FlutterFlowTheme.of(context).alternate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
