import '/components/popular_route_item/popular_route_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all_routes_model.dart';
export 'all_routes_model.dart';

class AllRoutesWidget extends StatefulWidget {
  const AllRoutesWidget({super.key});

  static String routeName = 'AllRoutes';
  static String routePath = '/allRoutes';

  @override
  State<AllRoutesWidget> createState() => _AllRoutesWidgetState();
}

class _AllRoutesWidgetState extends State<AllRoutesWidget> {
  late AllRoutesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllRoutesModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'All Popular Routes',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.plusJakartaSans(),
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemCount: _model.popularRoutes.length,
              itemBuilder: (context, index) {
                final route = _model.popularRoutes[index];
                return PopularRouteItemWidget(
                  key: Key('route_$index'),
                  route: route['route']!,
                  price: route['price']!,
                  imgDesc: route['img']!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
