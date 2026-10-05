import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        title: const Text('Privacy & Permissions'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.go(RouteNames.more),
        ),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          Text('On-Device Boundaries', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gallery Access Permission',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Currently in blueprint mode. When full implementation begins, permissions will request access only to selected albums or receipt photos.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Data Protection Guarantees', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zero Advertising Tracking',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'No third-party advertising SDKs or data brokers are integrated into this application.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
