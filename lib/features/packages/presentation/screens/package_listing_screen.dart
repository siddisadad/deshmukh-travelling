import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../providers/package_providers.dart';
import '../widgets/package_card.dart';
import '../../../../l10n/app_localizations.dart';

class HolidayPackageListingScreen extends ConsumerWidget {
  const HolidayPackageListingScreen({super.key});

  static String routeName = 'PackageListing';
  static String routePath = '/packageListing';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packagesResult = ref.watch(packagesProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          l10n.holidayPackages,
          style: AppTypography.titleMedium.copyWith(color: AppColors.onPrimary),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
      ),
      body: packagesResult.when(
        data: (result) {
          return result.when(
            data: (packages) {
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: packages.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  return PackageCard(package: packages[index]);
                },
              );
            },
            error: (error) => Center(
              child: Text('Error: ${error.message}'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
