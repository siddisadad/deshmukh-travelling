import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../features/packages/presentation/screens/package_listing_screen.dart';
import '../providers/home_dashboard_providers.dart';

class SearchSection extends ConsumerWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedService = ref.watch(selectedServiceProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectedService == 'Bus') ...[
            _buildLocationInput(context, 'From', 'Mumbai, Maharashtra', Icons.location_on_outlined),
            const SizedBox(height: AppSpacing.md),
            _buildLocationInput(context, 'To', 'Pune, Maharashtra', Icons.location_searching),
          ] else if (selectedService == 'Hotel') ...[
             _buildLocationInput(context, 'Destination', 'Mumbai, Maharashtra', Icons.hotel_outlined),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            text: 'Search $selectedService',
            onPressed: () {
              if (selectedService == 'Holiday') {
                context.pushNamed(HolidayPackageListingScreen.routeName);
              }
            },
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput(BuildContext context, String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(value, style: AppTypography.titleMedium),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
