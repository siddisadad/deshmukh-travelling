import 'package:flutter/material.dart';
import '../tokens.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, destructive }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor();
    final foregroundColor = _getForegroundColor();
    final borderRadius = _getBorderRadius();
    final padding = _getPadding();
    final borderSide = _getBorderSide();

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        else if (icon != null) ...[
          icon!,
          const SizedBox(width: AppSpacing.sm),
        ],
        if (!isLoading)
          Text(
            text,
            style: AppTypography.labelMedium.copyWith(
              color: foregroundColor,
            ),
          ),
      ],
    );

    if (isFullWidth) {
      content = SizedBox(width: double.infinity, child: content);
    }

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: (isDisabled || isLoading) ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: borderSide != null ? Border.fromBorderSide(borderSide) : null,
            ),
            child: content,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.primary;
      case AppButtonVariant.secondary:
        return AppColors.secondary;
      case AppButtonVariant.outline:
      case AppButtonVariant.ghost:
        return Colors.transparent;
      case AppButtonVariant.destructive:
        return AppColors.error;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.onPrimary;
      case AppButtonVariant.secondary:
        return AppColors.onSecondary;
      case AppButtonVariant.outline:
        return AppColors.textPrimary;
      case AppButtonVariant.ghost:
        return AppColors.primary;
      case AppButtonVariant.destructive:
        return AppColors.onError;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return AppRadius.sm;
      case AppButtonSize.medium:
        return AppRadius.md;
      case AppButtonSize.large:
        return AppRadius.lg;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        );
    }
  }

  BorderSide? _getBorderSide() {
    if (variant == AppButtonVariant.outline) {
      return const BorderSide(color: AppColors.alternate, width: 1.0);
    }
    return null;
  }
}
