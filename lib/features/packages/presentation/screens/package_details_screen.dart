import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../backend/schema/review_record.dart';
import '../../domain/entities/package_record.dart';
import '../widgets/reviews_list.dart';
import 'package_booking_screen.dart';
import '../../../../l10n/app_localizations.dart';

class HolidayPackageDetailsScreen extends ConsumerWidget {
  final PackageRecord package;

  const HolidayPackageDetailsScreen({
    super.key,
    required this.package,
  });

  static String routeName = 'PackageDetails';
  static String routePath = '/packageDetails';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black26,
                child: Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: package.images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.title,
                      style: AppTypography.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_outlined,
                                  size: 14, color: AppColors.primary),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                '${package.durationDays}D / ${package.durationNights}N',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 18, color: AppColors.warning),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              package.rating.toString(),
                              style: AppTypography.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _sectionTitle(l10n.overview),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      package.description,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _sectionTitle(l10n.inclusions),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: package.inclusions
                          .map((inc) => _chip(inc, Icons.check_circle_outline,
                              AppColors.success))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _sectionTitle(l10n.itinerary),
                    const SizedBox(height: AppSpacing.md),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: package.itinerary.length,
                      itemBuilder: (context, index) {
                        final day = package.itinerary[index];
                        return _itineraryDay(context, day,
                            isLast: index == package.itinerary.length - 1);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _sectionTitle(l10n.reviews),
                    const SizedBox(height: AppSpacing.md),
                    ReviewsList(reviews: [
                      ReviewRecord(
                        id: 'rev1',
                        userId: 'u1',
                        userName: 'Rahul Sharma',
                        userImage: '',
                        referenceId: package.id,
                        referenceType: 'package',
                        rating: 5,
                        comment: 'Amazing experience! The guide was very helpful and the locations were breath-taking.',
                        createdAt: DateTime.now().subtract(const Duration(days: 2)),
                      ),
                      ReviewRecord(
                        id: 'rev2',
                        userId: 'u2',
                        userName: 'Priya Patel',
                        userImage: '',
                        referenceId: package.id,
                        referenceType: 'package',
                        rating: 4,
                        comment: 'Good package, well managed. A bit tiring but worth it.',
                        createdAt: DateTime.now().subtract(const Duration(days: 5)),
                      ),
                    ]),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.totalCost, style: AppTypography.labelSmall),
                Text(
                  '₹${package.price.toStringAsFixed(0)}',
                  style: AppTypography.headlineMedium.copyWith(
                    fontSize: 24,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            AppButton(
              text: l10n.bookNow,
              onPressed: () {
                context.pushNamed(
                  HolidayPackageBookingScreen.routeName,
                  extra: <String, dynamic>{
                    'package': package,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _chip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }

  Widget _itineraryDay(BuildContext context, ItineraryDay day,
      {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                day.day.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                color: AppColors.alternate,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day.title,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  day.description,
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...day.activities.map((act) => Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_right,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              act,
                              style: AppTypography.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
