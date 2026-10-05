import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class SuggestedPromptChip extends StatelessWidget {
  const SuggestedPromptChip({
    super.key,
    required this.prompt,
    required this.onTap,
  });

  final String prompt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.radiusPill,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.radiusPill,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 16,
              color: AppColors.primaryGreen,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                prompt,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
