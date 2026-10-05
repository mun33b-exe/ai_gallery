import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  static final List<Map<String, String>> mockSubs = [
    {
      'name': 'Cloud Backup & Storage',
      'cycle': 'Renews on 12th of every month',
      'cost': 'PKR 1,200/mo',
      'status': 'Active',
    },
    {
      'name': 'Software Development IDE',
      'cycle': 'Renews Oct 28',
      'cost': 'PKR 2,500/mo',
      'status': 'Active',
    },
    {
      'name': 'Media Streaming Pass',
      'cycle': 'Renews Nov 2',
      'cost': 'PKR 950/mo',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(title: const Text('Subscriptions')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          AppCard(
            backgroundColor: AppColors.surface,
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly Recurring Total', style: AppTypography.bodySmall),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'PKR 4,650',
                  style: AppTypography.displayMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '3 recurring services automatically detected from bank alerts & receipts',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Active Subscriptions', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ...mockSubs.map(
            (sub) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: AppCard(
                padding: AppSpacing.cardPadding,
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenLight,
                        borderRadius: AppRadii.radiusMd,
                      ),
                      child: const Icon(
                        AppIcons.subscriptions,
                        color: AppColors.primaryGreenDark,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub['name']!,
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(sub['cycle']!, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                    Text(
                      sub['cost']!,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
