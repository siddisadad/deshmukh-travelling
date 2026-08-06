import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../domain/entities/home_dashboard_data.dart';

class DashboardSections extends StatelessWidget {
  final HomeDashboardData data;

  const DashboardSections({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.recentSearches.isNotEmpty) ...[
            _sectionHeader('Recent Searches'),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.recentSearches.length,
                itemBuilder: (context, index) {
                  final search = data.recentSearches[index];
                  return _recentSearchItem(search);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
          _buildHajjBanner(context),
          const SizedBox(height: AppSpacing.xl),
          _sectionHeader('Popular Destinations'),
          const SizedBox(height: AppSpacing.md),
          ...data.popularDestinations.map((d) => _destinationCard(d)).toList(),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _recentSearchItem(SearchHistoryEntity search) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.alternate),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(search.from, style: AppTypography.labelMedium, overflow: TextOverflow.ellipsis),
          const Icon(Icons.arrow_downward, size: 12, color: AppColors.textSecondary),
          Text(search.to, style: AppTypography.labelMedium, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _destinationCard(DestinationEntity destination) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            child: Image.network(destination.image, height: 150, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(destination.title, style: AppTypography.titleMedium),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(destination.rating.toString(), style: AppTypography.labelMedium),
                      ],
                    ),
                  ],
                ),
                Text(destination.subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: AppSpacing.sm),
                Text(destination.price, style: AppTypography.titleMedium.copyWith(color: AppColors.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHajjBanner(BuildContext context) {
    const emeraldGreen = Color(0xFF06402B);
    const metallicGold = Color(0xFFD4AF37);

    return InkWell(
      onTap: () => context.pushNamed('HajjDashboard'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [emeraldGreen, Color(0xFF0A5C3E)],
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: emeraldGreen.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: metallicGold,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'PREMIUM',
                      style: AppTypography.labelSmall.copyWith(
                        color: emeraldGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Journey of a Lifetime',
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Enterprise Hajj & Umrah bookings now open for 2026.',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.mosque_rounded, color: metallicGold, size: 48),
          ],
        ),
      ),
    );
  }
}
