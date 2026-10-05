import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_event.dart';
import '../../../auth/bloc/auth_state.dart';
import '../widgets/settings_tile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

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
        final userInitials = authState is AuthAuthenticated
            ? authState.user.initials
            : AppConstants.defaultUserInitials;

        return AppScaffold(
          showBlueprintBanner: true,
          appBar: AppBar(
            title: const Text('More & Settings'),
            leading: IconButton(
              icon: const Icon(AppIcons.back),
              onPressed: () => context.go(RouteNames.home),
            ),
          ),
          body: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              AppCard(
                padding: AppSpacing.cardPadding,
                child: Row(
                  children: [
                    AppAvatar(initials: userInitials, size: 52),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userName, style: AppTypography.titleLarge),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(userEmail, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Text('Preferences & Controls', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),

              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SettingsTile(
                      title: 'Account & Profile',
                      subtitle: 'Manage identity & credentials',
                      icon: AppIcons.account,
                      onTap: () => context.go(RouteNames.settingsAccount),
                    ),
                    const Divider(),
                    SettingsTile(
                      title: 'Privacy & Permissions',
                      subtitle: 'Photo access boundary and local security',
                      icon: AppIcons.privacy,
                      onTap: () => context.go(RouteNames.settingsPrivacy),
                    ),
                    const Divider(),
                    SettingsTile(
                      title: 'Data Management',
                      subtitle: 'Export records, clear cache & storage',
                      icon: AppIcons.dataManagement,
                      onTap: () => context.go(RouteNames.settingsData),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              AppCard(
                padding: EdgeInsets.zero,
                child: SettingsTile(
                  title: 'Sign out',
                  subtitle: 'End current authentication session',
                  icon: AppIcons.logout,
                  isDestructive: true,
                  trailing: const SizedBox.shrink(),
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Center(
                child: Text(
                  'Gallery Finance AI · v1.0.0 (Blueprint)',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
