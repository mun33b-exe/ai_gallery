import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primaryGreenLight,
            borderRadius: AppRadii.radiusXl,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 36, color: AppColors.primaryGreenDark),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          title,
          style: AppTypography.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          description,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
