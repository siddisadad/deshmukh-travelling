import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/app_nav_bar.dart';
import '/components/app_header.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/tokens.dart';
import '../widgets/islamic_card.dart';

class HajjDashboardScreen extends ConsumerWidget {
  static const String routeName = 'HajjDashboard';
  const HajjDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppNavBar(currentRoute: HajjDashboardScreen.routeName),
      body: Column(
        children: [
          AppHeader(
            title: 'Hajj & Umrah',
            showBackButton: true,
            actionWidget: IconButton(
              icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upcoming Journey Card
                  IslamicCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: const Icon(Icons.flight_takeoff_rounded, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              'Your Upcoming Journey',
                              style: AppTypography.labelMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Hajj Premium Package 2026',
                          style: AppTypography.displayLarge.copyWith(
                            color: Colors.white,
                            fontSize: 24, // Optimized for this header
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoItem('Departure', '15 Jun 2026'),
                              _buildInfoItem('Duration', '21 Days'),
                              _buildInfoItem('Status', 'Visa Pending', isStatus: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Quick Actions Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Actions',
                        style: AppTypography.titleLarge,
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('HajjPackages'),
                        child: const Text('See All', style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    children: [
                      _buildQuickAction(context, Icons.card_travel_rounded, 'Packages', AppColors.islamicGold, () {
                        context.pushNamed('HajjPackages');
                      }),
                      _buildQuickAction(context, Icons.access_time_filled_rounded, 'Prayers', AppColors.islamicGreen, () {
                        context.pushNamed('IslamicTools');
                      }),
                      _buildQuickAction(context, Icons.menu_book_rounded, 'Duas', AppColors.islamicGreen, () {
                        context.pushNamed('IslamicTools');
                      }),
                      _buildQuickAction(context, Icons.explore_rounded, 'Qibla', AppColors.islamicGreen, () {
                        context.pushNamed('IslamicTools');
                      }),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Journey Progress Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Preparation Status',
                        style: AppTypography.titleLarge,
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('MyJourney'),
                        child: const Text('See All', style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: AppShadows.sm,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        children: [
                          _buildStep(context, Icons.check_circle_rounded, 'Package Selected', 'Premium Hajj 2026', true, true),
                          _buildStepDivider(),
                          _buildStep(context, Icons.check_circle_rounded, 'Payments Completed', 'Full amount received', true, false),
                          _buildStepDivider(),
                          _buildStep(context, Icons.radio_button_unchecked_rounded, 'Visa Processing', 'In progress with embassy', false, false),
                          _buildStepDivider(),
                          _buildStep(context, Icons.radio_button_unchecked_rounded, 'Flight Booking', 'Scheduled for next week', false, false),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => context.pushNamed('MyJourney'),
                      icon: const Icon(Icons.assignment_rounded, size: 18),
                      label: const Text('View Full Journey Timeline'),
                      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {bool isStatus = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: Colors.white.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.islamicGold,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: AppShadows.sm,
            ),
            child: Text(
              value,
              style: AppTypography.labelMedium.copyWith(color: Colors.white),
            ),
          )
        else
          Text(
            value,
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
      ],
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, IconData icon, String title, String subtitle, bool isCompleted, bool isFirst) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: isCompleted ? AppColors.primary : Colors.grey[300],
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isCompleted ? AppTypography.titleSmall : AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.verified_rounded, color: AppColors.primary, size: 16),
        ],
      ),
    );
  }

  Widget _buildStepDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 11, top: 2, bottom: 2),
      width: 2,
      height: 20,
      color: Colors.grey[100],
    );
  }
}
