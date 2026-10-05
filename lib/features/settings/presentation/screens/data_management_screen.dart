import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';

class DataManagementScreen extends StatelessWidget {
  const DataManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        title: const Text('Data Management'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.go(RouteNames.more),
        ),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          Text('Local Storage & Cache', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Extracted Document Data',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Currently utilizing mock storage. In future phases, you can export your entire extracted ledger as CSV or JSON format.',
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Export Records (Blueprint Preview)',
                  variant: AppButtonVariant.outline,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
