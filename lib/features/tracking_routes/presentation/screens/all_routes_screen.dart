import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../components/app_header.dart';
import '../../../../components/popular_route_item/popular_route_item_widget.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../providers/tracking_providers.dart';

class AllRoutesScreen extends ConsumerWidget {
  const AllRoutesScreen({super.key});

  static String routeName = 'AllRoutes';
  static String routePath = '/allRoutes';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesAsync = ref.watch(popularRoutesProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'All Popular Routes'),
          Expanded(
            child: routesAsync.when(
              data: (routes) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return PopularRouteItemWidget(
                      key: Key('route_$index'),
                      route: route.routeName,
                      price: route.price,
                      imgDesc: route.imageUrl,
                    );
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
