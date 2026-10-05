import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';

class ComparisonBars extends StatelessWidget {
  const ComparisonBars({
    super.key,
    required this.spentAmount,
    required this.receivedAmount,
    required this.currency,
    this.isInvertedOnGreen = true,
  });

  final double spentAmount;
  final double receivedAmount;
  final String currency;
  final bool isInvertedOnGreen;

  @override
  Widget build(BuildContext context) {
    final total = spentAmount + receivedAmount;
    final spentFlex = total > 0 ? (spentAmount / total * 100).round() : 50;
    final receivedFlex = total > 0 ? 100 - spentFlex : 50;

    final textColor = isInvertedOnGreen
        ? AppColors.textWhite
        : AppColors.textPrimary;
    final textMutedColor = isInvertedOnGreen
        ? Colors.white.withValues(alpha: 0.85)
        : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isInvertedOnGreen
                            ? const Color(0xFFFFD4D0)
                            : AppColors.outgoing,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Spent (Outgoing)',
                      style: AppTypography.labelSmall.copyWith(
                        color: textMutedColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  Formatters.formatCurrency(spentAmount, currency),
                  style: AppTypography.titleMedium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isInvertedOnGreen
                            ? Colors.white
                            : AppColors.incoming,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Received (Incoming)',
                      style: AppTypography.labelSmall.copyWith(
                        color: textMutedColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  Formatters.formatCurrency(receivedAmount, currency),
                  style: AppTypography.titleMedium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Visual comparison bar
        ClipRRect(
          borderRadius: AppRadii.radiusPill,
          child: Container(
            height: 10,
            width: double.infinity,
            color: isInvertedOnGreen
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.gray200,
            child: Row(
              children: [
                Expanded(
                  flex: spentFlex,
                  child: Container(
                    color: isInvertedOnGreen
                        ? const Color(0xFFFF998F)
                        : AppColors.outgoing,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: receivedFlex,
                  child: Container(
                    color: isInvertedOnGreen
                        ? Colors.white
                        : AppColors.incoming,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
