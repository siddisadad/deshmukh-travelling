import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/components/app_nav_bar.dart';
import '/components/app_header.dart';
import 'hajj_dashboard_screen.dart';
import '../../domain/entities/hajj_package.dart';
import '../providers/hajj_providers.dart';
import '../widgets/package_card.dart';

class PackageListingScreen extends ConsumerStatefulWidget {
  final PackageType? type;
  const PackageListingScreen({super.key, this.type});

  @override
  ConsumerState<PackageListingScreen> createState() => _PackageListingScreenState();
}

class _PackageListingScreenState extends ConsumerState<PackageListingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.type == PackageType.umrah ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      bottomNavigationBar: const AppNavBar(currentRoute: HajjDashboardScreen.routeName),
      body: Column(
        children: [
          AppHeader(
            title: 'Travel Packages',
            bottom: TabBar(
              controller: _tabController,
              labelColor: FlutterFlowTheme.of(context).primary,
              unselectedLabelColor: FlutterFlowTheme.of(context).secondaryText,
              indicatorColor: FlutterFlowTheme.of(context).primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'HAJJ'),
                Tab(text: 'UMRAH'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PackageList(type: PackageType.hajj),
                _PackageList(type: PackageType.umrah),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageList extends ConsumerWidget {
  final PackageType type;

  const _PackageList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packagesAsync = ref.watch(hajjPackagesProvider(type));

    return packagesAsync.when(
      data: (packages) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: PackageCard(
              package: package,
              onTap: () {
                context.pushNamed('HajjPackageDetails', queryParameters: {'id': package.id});
              },
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF06402B))),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
