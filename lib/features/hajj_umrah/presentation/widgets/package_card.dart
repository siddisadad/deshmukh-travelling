import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/entities/hajj_package.dart';

class PackageCard extends StatelessWidget {
  final HajjPackage package;
  final VoidCallback onTap;

  const PackageCard({
    super.key,
    required this.package,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.sm,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'package_${package.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                    child: Image.network(
                      package.images.isNotEmpty
                          ? package.images[0]
                          : 'https://images.unsplash.com/photo-1564767609342-620cb19b2357',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay for readability
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                if (package.isPremium)
                  Positioned(
                    top: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.islamicGold,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        boxShadow: AppShadows.sm,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars_rounded, color: Colors.white, size: 16),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'PREMIUM',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      package.type == PackageType.hajj ? 'Hajj 2026' : 'Umrah Special',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.islamicGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          package.title,
                          style: AppTypography.titleLarge,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Starting from',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            '\$${package.price.toStringAsFixed(0)}',
                            style: AppTypography.displayLarge.copyWith(
                              color: AppColors.islamicGold,
                              fontSize: 22, // Override displayLarge for this specific card context
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      children: [
                        _buildInfoIcon(Icons.calendar_today_rounded, package.duration),
                        const Spacer(),
                        _buildInfoIcon(Icons.hotel_rounded, package.makkahHotel ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.islamicGreen.withValues(alpha: 0.6)),
        const SizedBox(width: AppSpacing.xs),
        Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
