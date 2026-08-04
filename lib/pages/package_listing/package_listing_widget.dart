import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/package_record.dart';
import '../package_details/package_details_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deshmukh_travelling/pages/package_listing/package_listing_model.dart';

class PackageListingWidget extends StatefulWidget {
  const PackageListingWidget({super.key});

  static String routeName = 'PackageListing';
  static String routePath = '/packageListing';

  @override
  State<PackageListingWidget> createState() => _PackageListingWidgetState();
}

class _PackageListingWidgetState extends State<PackageListingWidget> {
  late PackageListingModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackageListingModel());
    _model.fetchPackages().then((_) => safeSetState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          buttonSize: 60.0,
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Holiday Packages',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.plusJakartaSans(),
                color: Colors.white,
                fontSize: 22.0,
              ),
        ),
        elevation: 2.0,
      ),
      body: _model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _model.packages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final package = _model.packages[index];
                return _packageCard(package);
              },
            ),
    );
  }

  Widget _packageCard(PackageRecord package) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          PackageDetailsWidget.routeName,
          extra: <String, dynamic>{
            'package': package,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: package.images.first,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${package.durationDays}D / ${package.durationNights}N',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).warning, size: 16),
                          Text(package.rating.toString(), style: FlutterFlowTheme.of(context).labelSmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.title,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    package.destinations.join(' • '),
                    style: FlutterFlowTheme.of(context).bodySmall,
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Starting Price', style: FlutterFlowTheme.of(context).labelSmall),
                          Text(
                            '₹${package.price.toStringAsFixed(0)}',
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward, color: FlutterFlowTheme.of(context).primary, size: 32),
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
