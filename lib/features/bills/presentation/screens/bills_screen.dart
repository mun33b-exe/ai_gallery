import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  static final List<Map<String, String>> mockBills = [
    {
      'title': 'Electricity Utility Bill',
      'date': 'Due in 3 days',
      'amount': 'PKR 8,450',
      'status': 'Pending Review',
    },
    {
      'title': 'High-Speed Fiber Internet',
      'date': 'Due Oct 15',
      'amount': 'PKR 3,200',
      'status': 'Scheduled',
    },
    {
      'title': 'Supermarket Grocery Invoice',
      'date': 'Oct 3, 2026',
      'amount': 'PKR 5,120',
      'status': 'Extracted',
    },
    {
      'title': 'Fuel Receipt #882',
      'date': 'Oct 1, 2026',
      'amount': 'PKR 4,000',
      'status': 'Extracted',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        title: const Text('Bills & Receipts'),
        actions: [
          IconButton(icon: const Icon(AppIcons.filter), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: mockBills.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final bill = mockBills[index];
          final isPending = bill['status'] == 'Pending Review';

          return AppCard(
            padding: AppSpacing.cardPadding,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isPending
                        ? AppColors.warningSubtle
                        : AppColors.primaryGreenLight,
                    borderRadius: AppRadii.radiusMd,
                  ),
                  child: Icon(
                    AppIcons.bills,
                    color: isPending
                        ? AppColors.warning
                        : AppColors.primaryGreenDark,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bill['title']!,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(bill['date']!, style: AppTypography.bodySmall),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      bill['amount']!,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      bill['status']!,
                      style: AppTypography.labelSmall.copyWith(
                        color: isPending
                            ? AppColors.warning
                            : AppColors.primaryGreenDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
