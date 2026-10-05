import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDestructive
        ? AppColors.outgoing
        : AppColors.textPrimary;
    final iconColor = isDestructive ? AppColors.outgoing : AppColors.gray700;
    final iconBgColor = isDestructive
        ? AppColors.outgoingSubtle
        : AppColors.gray100;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: AppRadii.radiusSm,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(subtitle!, style: AppTypography.bodySmall),
                  ],
                ],
              ),
            ),
            trailing ??
                const Icon(
                  AppIcons.chevronRight,
                  size: 20,
                  color: AppColors.textMuted,
                ),
          ],
        ),
      ),
    );
  }
}
