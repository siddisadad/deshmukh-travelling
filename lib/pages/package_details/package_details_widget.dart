import 'components/reviews_list.dart';
import '../../../backend/schema/review_record.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import '../../backend/schema/package_record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deshmukh_travelling/pages/package_details/package_details_model.dart';

class PackageDetailsWidget extends StatefulWidget {
  final PackageRecord package;

  const PackageDetailsWidget({super.key, required this.package});

  static String routeName = 'PackageDetails';
  static String routePath = '/packageDetails';

  @override
  State<PackageDetailsWidget> createState() => _PackageDetailsWidgetState();
}

class _PackageDetailsWidgetState extends State<PackageDetailsWidget> {
  @override
  void initState() {
    super.initState();
    createModel(context, () => PackageDetailsModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: FlutterFlowIconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30.0),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.package.images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.package.title,
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16, color: FlutterFlowTheme.of(context).secondaryText),
                        const SizedBox(width: 4),
                        Text('${widget.package.durationDays} Days / ${widget.package.durationNights} Nights', style: FlutterFlowTheme.of(context).bodySmall),
                        const SizedBox(width: 16),
                        Icon(Icons.star_rounded, size: 16, color: FlutterFlowTheme.of(context).warning),
                        Text(widget.package.rating.toString(), style: FlutterFlowTheme.of(context).bodySmall),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Overview', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 8),
                    Text(widget.package.description, style: FlutterFlowTheme.of(context).bodyMedium),
                    const SizedBox(height: 24),
                    Text('Inclusions', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.package.inclusions.map((inc) => _chip(inc, Icons.check_circle_outline, Colors.green)).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text('Itinerary', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.package.itinerary.length,
                      itemBuilder: (context, index) {
                        final day = widget.package.itinerary[index];
                        return _itineraryDay(day);
                      },
                    ),
                    const SizedBox(height: 32),
                    Text('Reviews', style: FlutterFlowTheme.of(context).titleMedium.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 16),
                    ReviewsList(reviews: [
                      ReviewRecord(
                        id: 'rev1',
                        userId: 'u1',
                        userName: 'Rahul Sharma',
                        userImage: '',
                        referenceId: widget.package.id,
                        referenceType: 'package',
                        rating: 5,
                        comment: 'Amazing experience! The guide was very helpful and the locations were breath-taking.',
                        createdAt: DateTime.now().subtract(const Duration(days: 2)),
                      ),
                      ReviewRecord(
                        id: 'rev2',
                        userId: 'u2',
                        userName: 'Priya Patel',
                        userImage: '',
                        referenceId: widget.package.id,
                        referenceType: 'package',
                        rating: 4,
                        comment: 'Good package, well managed. A bit tiring but worth it.',
                        createdAt: DateTime.now().subtract(const Duration(days: 5)),
                      ),
                    ]),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [BoxShadow(blurRadius: 10, color: Color(0x1A000000), offset: Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Cost', style: FlutterFlowTheme.of(context).labelSmall),
                Text('₹${widget.package.price.toStringAsFixed(0)}', style: FlutterFlowTheme.of(context).titleLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold), color: FlutterFlowTheme.of(context).primary)),
              ],
            ),
            ButtonWidget(
              content: 'Book Now',
              variant: 'primary',
              size: 'large',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Package booking flow coming soon')));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: FlutterFlowTheme.of(context).labelSmall),
        ],
      ),
    );
  }

  Widget _itineraryDay(ItineraryDay day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primary, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(day.day.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Container(width: 2, height: 100, color: FlutterFlowTheme.of(context).alternate),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day.title, style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                const SizedBox(height: 4),
                Text(day.description, style: FlutterFlowTheme.of(context).bodySmall),
                const SizedBox(height: 8),
                ...day.activities.map((act) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right, size: 16, color: FlutterFlowTheme.of(context).primary),
                          Text(act, style: FlutterFlowTheme.of(context).bodySmall),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
