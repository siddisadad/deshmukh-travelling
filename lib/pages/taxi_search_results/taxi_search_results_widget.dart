import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'taxi_search_results_model.dart';
export 'taxi_search_results_model.dart';

class TaxiSearchResultsWidget extends StatefulWidget {
  final String? from;
  final String? to;

  const TaxiSearchResultsWidget({
    super.key,
    this.from,
    this.to,
  });

  static String routeName = 'TaxiSearchResults';
  static String routePath = '/taxiSearchResults';

  @override
  State<TaxiSearchResultsWidget> createState() => _TaxiSearchResultsWidgetState();
}

class _TaxiSearchResultsWidgetState extends State<TaxiSearchResultsWidget> {
  late TaxiSearchResultsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaxiSearchResultsModel());
    _model.fetchTaxis().then((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Taxis Available',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.plusJakartaSans(),
                      color: Colors.white,
                      fontSize: 18,
                    ),
              ),
              Text(
                '${widget.from?.split(',').first ?? 'Origin'} → ${widget.to?.split(',').first ?? 'Dest'}',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(),
                      color: FlutterFlowTheme.of(context).onPrimary80,
                    ),
              ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: _model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: _model.taxis.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final taxi = _model.taxis[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            FlutterFlowTheme.of(context).designToken.shadow.sm
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  taxi.image,
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taxi.name,
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                            font: GoogleFonts.plusJakartaSans(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      taxi.type,
                                      style: FlutterFlowTheme.of(context).bodySmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star_rounded,
                                            color: FlutterFlowTheme.of(context).warning, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          taxi.rating.toString(),
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                font: GoogleFonts.inter(),
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(Icons.access_time_rounded,
                                            color: FlutterFlowTheme.of(context).secondaryText, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          taxi.estimatedTime,
                                          style: FlutterFlowTheme.of(context).bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    taxi.price,
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Booking ${taxi.name}...')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: FlutterFlowTheme.of(context).primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                    child: const Text('Book', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
