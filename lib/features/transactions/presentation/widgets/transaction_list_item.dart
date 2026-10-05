import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.id,
    required this.merchant,
    required this.category,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.onTap,
  });

  final String id;
  final String merchant;
  final String category;
  final DateTime date;
  final double amount;
  final bool isExpense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final amountColor = isExpense ? AppColors.outgoing : AppColors.incoming;
    final iconBgColor = isExpense
        ? AppColors.outgoingSubtle
        : AppColors.incomingSubtle;
    final iconColor = isExpense ? AppColors.outgoing : AppColors.incoming;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenMargin,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: AppRadii.radiusMd,
              ),
              child: Icon(
                isExpense ? AppIcons.outgoing : AppIcons.incoming,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    merchant,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '$category · ${Formatters.formatShortDate(date)}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
            Text(
              Formatters.formatSignedCurrency(amount, isExpense: isExpense),
              style: AppTypography.titleMedium.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
