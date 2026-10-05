import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class AuthFooterLinks extends StatelessWidget {
  const AuthFooterLinks({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(promptText, style: AppTypography.bodyMedium),
            const SizedBox(width: AppSpacing.xs),
            GestureDetector(
              onTap: onTap,
              child: Text(
                actionText,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primaryGreenDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
