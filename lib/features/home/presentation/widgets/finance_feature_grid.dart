import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import 'finance_feature_tile.dart';

class FinanceFeatureGrid extends StatelessWidget {
  const FinanceFeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FinanceFeatureTile(
                title: 'Bills & Receipts',
                subtitle: '12 extracted docs',
                icon: AppIcons.bills,
                badgeText: 'Active',
                onTap: () => context.go(RouteNames.bills),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: FinanceFeatureTile(
                title: 'Subscriptions',
                subtitle: '4 recurring services',
                icon: AppIcons.subscriptions,
                badgeText: 'Monthly',
                onTap: () => context.go(RouteNames.subscriptions),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        FinanceFeatureTile(
          title: 'All Transactions',
          subtitle: 'View detailed chronological ledger & categorization',
          icon: AppIcons.transactions,
          badgeText: '126 items',
          onTap: () => context.go(RouteNames.transactions),
        ),
      ],
    );
  }
}
