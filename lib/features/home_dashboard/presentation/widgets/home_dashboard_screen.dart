import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../providers/home_dashboard_providers.dart';
import 'dashboard_header.dart';
import 'service_selector.dart';
import 'search_section.dart';
import 'dashboard_sections.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  static const String routeName = 'HomeDashboard';
  static const String routePath = '/homeDashboard';

  @override
  ConsumerState<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // For now, using a hardcoded userId. In a real app, get it from Auth provider.
    const userId = 'user_123';
    final dashboardDataAsync = ref.watch(homeDashboardDataProvider(userId));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      body: dashboardDataAsync.when(
        data: (data) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppRadius.xxl),
                        bottomRight: Radius.circular(AppRadius.xxl),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        const DashboardHeader(),
                        const SizedBox(height: AppSpacing.lg),
                        const ServiceSelector(),
                        const SizedBox(height: AppSpacing.lg),
                        const SearchSection(),
                      ],
                    ),
                  ),
                ],
              ),
              DashboardSections(data: data),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
