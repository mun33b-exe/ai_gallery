import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        title: const Text('Transaction Details'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.go(RouteNames.transactions),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.outgoingSubtle,
                      borderRadius: AppRadii.radiusXl,
                    ),
                    child: const Icon(
                      AppIcons.outgoing,
                      color: AppColors.outgoing,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Metro Supermarket',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '-PKR 1,850',
                    style: AppTypography.displayMedium.copyWith(
                      color: AppColors.outgoing,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppCard(
              padding: AppSpacing.cardPadding,
              child: Column(
                children: [
                  _DetailRow(label: 'Transaction ID', value: transactionId),
                  const Divider(),
                  const _DetailRow(label: 'Category', value: 'Groceries'),
                  const Divider(),
                  const _DetailRow(
                    label: 'Payment Method',
                    value: 'Debit Card',
                  ),
                  const Divider(),
                  const _DetailRow(label: 'Status', value: 'Confirmed'),
                  const Divider(),
                  const _DetailRow(label: 'Source', value: 'Receipt photo #21'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: AppRadii.radiusMd,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.photo_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Source image preview and OCR bounding boxes will be linked here in future phases.',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            AppButton(
              label: 'Back to transactions',
              variant: AppButtonVariant.outline,
              onPressed: () => context.go(RouteNames.transactions),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium),
          Text(
            value,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
