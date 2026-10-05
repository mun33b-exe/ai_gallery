import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: AppRadii.radiusMd,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            color: AppColors.textWhite,
            size: 26,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(title, style: AppTypography.displayMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitle, style: AppTypography.bodyMedium),
      ],
    );
  }
}
