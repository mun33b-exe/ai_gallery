import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class ReviewNeededRow extends StatelessWidget {
  const ReviewNeededRow({
    super.key,
    required this.count,
    required this.message,
    this.onTap,
  });

  final int count;
  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.cardRadius,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.warningSubtle,
            borderRadius: AppRadii.cardRadius,
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  AppIcons.reviewNeeded,
                  color: AppColors.warning,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                AppIcons.chevronRight,
                size: 18,
                color: AppColors.gray500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
