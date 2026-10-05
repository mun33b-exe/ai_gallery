import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_state.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final userName = authState is AuthAuthenticated
            ? authState.user.displayName
            : AppConstants.defaultUserName;
        final userEmail = authState is AuthAuthenticated
            ? authState.user.email
            : 'muneeb@example.com';
        final isAnonymous = authState is AuthAuthenticated
            ? authState.user.isAnonymous
            : false;

        return AppScaffold(
          showBlueprintBanner: true,
          appBar: AppBar(
            title: const Text('Account & Profile'),
            leading: IconButton(
              icon: const Icon(AppIcons.back),
              onPressed: () => context.go(RouteNames.more),
            ),
          ),
          body: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              Text('Account Identity', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    _InfoRow(label: 'Full Name', value: userName),
                    const Divider(),
                    _InfoRow(label: 'Email Address', value: userEmail),
                    const Divider(),
                    _InfoRow(
                      label: 'Account Status',
                      value: isAnonymous ? 'Guest session' : 'Active member',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Membership & Tier', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                padding: AppSpacing.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard Tier (Blueprint Phase)',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'In-app purchases, billing, and subscription entitlement verification are intentionally postponed to later development phases.',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

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
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
