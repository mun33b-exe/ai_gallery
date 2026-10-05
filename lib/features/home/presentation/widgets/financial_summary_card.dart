import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/dashboard_summary.dart';
import 'comparison_bars.dart';

class FinancialSummaryCard extends StatelessWidget {
  const FinancialSummaryCard({super.key, required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: AppRadii.cardRadius,
        boxShadow: AppShadows.card,
      ),
      padding: AppSpacing.cardPaddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppRadii.radiusPill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 13,
                      color: AppColors.textWhite,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      summary.periodLabel,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Financial Overview',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Net Flow',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            Formatters.formatSignedCurrency(
              summary.netBalance,
              isExpense: summary.netBalance < 0,
              currency: summary.currency,
            ),
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: AppSpacing.lg),
          ComparisonBars(
            spentAmount: summary.spentAmount,
            receivedAmount: summary.receivedAmount,
            currency: summary.currency,
            isInvertedOnGreen: true,
          ),
        ],
      ),
    );
  }
}
