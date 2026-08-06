import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hotel_card_model.dart';
export 'hotel_card_model.dart';

class HotelCardWidget extends StatefulWidget {
  final String name;
  final String location;
  final double rating;
  final int reviewsCount;
  final String image;
  final double price;
  final VoidCallback onTap;

  const HotelCardWidget({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.image,
    required this.price,
    required this.onTap,
  });

  @override
  State<HotelCardWidget> createState() => _HotelCardWidgetState();
}

class _HotelCardWidgetState extends State<HotelCardWidget> {
  late HotelCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelCardModel());
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
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.image,
                width: double.infinity,
                height: 180.0,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: 180.0,
                  color: FlutterFlowTheme.of(context).alternate,
                  child: Icon(
                    Icons.hotel_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).success, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                    color: FlutterFlowTheme.of(context).success,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: FlutterFlowTheme.of(context).secondaryText, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        widget.location,
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '(${widget.reviewsCount} reviews)',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Starting from',
                            style: FlutterFlowTheme.of(context).labelSmall.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                          ),
                          Text(
                            '₹${widget.price.toStringAsFixed(0)}',
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                        ],
                      ),
                    ],
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
