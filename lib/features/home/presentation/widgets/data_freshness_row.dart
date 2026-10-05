import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class DataFreshnessRow extends StatelessWidget {
  const DataFreshnessRow({
    super.key,
    required this.freshnessText,
    this.onRefresh,
  });

  final String freshnessText;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                freshnessText,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (onRefresh != null)
            GestureDetector(
              onTap: onRefresh,
              child: const Icon(
                AppIcons.freshSync,
                size: 16,
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}
