import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'premium_card_model.dart';
export 'premium_card_model.dart';

class PremiumCardWidget extends StatefulWidget {
  const PremiumCardWidget({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    this.rating,
    this.price,
    this.onTap,
    this.width = 200.0,
  });

  final String image;
  final String title;
  final String? subtitle;
  final double? rating;
  final String? price;
  final VoidCallback? onTap;
  final double width;

  @override
  State<PremiumCardWidget> createState() => _PremiumCardWidgetState();
}

class _PremiumCardWidgetState extends State<PremiumCardWidget> {
  late PremiumCardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PremiumCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
          boxShadow: [FlutterFlowTheme.of(context).designToken.shadow.sm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                    topRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    width: widget.width,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                if (widget.rating != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).fullContrast67,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).warning, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.rating.toString(),
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.plusJakartaSans(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  if (widget.price != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.price!,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(),
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
