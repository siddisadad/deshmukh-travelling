import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deshmukh',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Explore the world with ease',
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ),
      ],
    );
  }
}
