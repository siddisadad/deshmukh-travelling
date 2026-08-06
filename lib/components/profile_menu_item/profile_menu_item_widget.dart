import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_menu_item_model.dart';
export 'profile_menu_item_model.dart';

class ProfileMenuItemWidget extends StatefulWidget {
  const ProfileMenuItemWidget({
    super.key,
    this.icon,
    String? subtitle,
    String? title,
    this.onTap,
  })  : this.subtitle = subtitle ?? 'Manage your data and identity',
        this.title = title ?? 'Personal Information';

  final Widget? icon;
  final String subtitle;
  final String title;
  final VoidCallback? onTap;

  @override
  State<ProfileMenuItemWidget> createState() => _ProfileMenuItemWidgetState();
}

class _ProfileMenuItemWidgetState extends State<ProfileMenuItemWidget> {
  late ProfileMenuItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileMenuItemModel());

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
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
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
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: widget.icon!,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              lineHeight: 1.5,
                            ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              lineHeight: 1.4,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Icon(
                  Icons.chevron_right_rounded,
                  color: FlutterFlowTheme.of(context).accent3,
                  size: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
