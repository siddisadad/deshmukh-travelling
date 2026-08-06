import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';

class IslamicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? backgroundColor;

  const IslamicCard({
    super.key,
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.islamicGreen, // Emerald Green
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.islamicGold.withValues(alpha: 0.5), // Soft Gold
          width: 1.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor ?? AppColors.islamicGreen,
            (backgroundColor ?? AppColors.islamicGreen).withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.islamicGreen.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Pattern Overlay (Geometric Islamic Pattern)
          Positioned(
            right: -20,
            top: -20,
            child: Opacity(
              opacity: 0.08,
              child: Transform.rotate(
                angle: 0.5,
                child: const Icon(
                  Icons.grid_4x4_rounded,
                  size: 180,
                  color: AppColors.islamicGold,
                ),
              ),
            ),
          ),
          // Soft Glow
          Positioned(
            left: -50,
            bottom: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.islamicGold.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}
