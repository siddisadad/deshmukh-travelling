import 'package:flutter/material.dart';
import '../tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.onTap,
    this.elevation = 0,
    this.hasShadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double elevation;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppRadius.lg;

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      child: child,
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        boxShadow: hasShadow ? AppShadows.sm : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        elevation: elevation,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: content,
        ),
      ),
    );
  }
}
