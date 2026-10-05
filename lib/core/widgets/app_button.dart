import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radii.dart';
import '../../app/theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    Widget childWidget;
    if (isLoading) {
      final spinnerColor = variant == AppButtonVariant.primary
          ? AppColors.textWhite
          : AppColors.primaryGreen;
      childWidget = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
        ),
      );
    } else if (icon != null) {
      childWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    } else {
      childWidget = Text(label);
    }

    final double width = isFullWidth ? double.infinity : double.nan;

    switch (variant) {
      case AppButtonVariant.primary:
        return SizedBox(
          width: isFullWidth ? width : null,
          height: 50,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.textWhite,
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadii.buttonRadius,
              ),
              elevation: 0,
            ),
            child: childWidget,
          ),
        );

      case AppButtonVariant.secondary:
        return SizedBox(
          width: isFullWidth ? width : null,
          height: 50,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreenLight,
              foregroundColor: AppColors.primaryGreenDark,
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadii.buttonRadius,
              ),
              elevation: 0,
            ),
            child: childWidget,
          ),
        );

      case AppButtonVariant.outline:
        return SizedBox(
          width: isFullWidth ? width : null,
          height: 50,
          child: OutlinedButton(
            onPressed: effectiveOnPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.border),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadii.buttonRadius,
              ),
            ),
            child: childWidget,
          ),
        );

      case AppButtonVariant.text:
        return SizedBox(
          width: isFullWidth ? width : null,
          height: 44,
          child: TextButton(onPressed: effectiveOnPressed, child: childWidget),
        );
    }
  }
}
