import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_step_indicator.dart';

class PhotoAccessPreviewScreen extends StatelessWidget {
  const PhotoAccessPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.go(RouteNames.onboardingPrivacy),
        ),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            const Spacer(),
            const OnboardingHeader(
              icon: Icons.photo_library_outlined,
              title: 'Photo access preview',
              description: 'Gallery Finance AI will scan your receipt and invoice photos to extract transactions automatically.',
            ),
            const SizedBox(height: AppSpacing.xxl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.security_update_good_rounded,
                    color: AppColors.primaryGreen,
                    size: 32,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Integration Notice', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Native photo picker and gallery permissions will be connected in future iterations. For now, sample mock data is provided in the dashboard.',
                    style: AppTypography.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const OnboardingStepIndicator(currentStep: 2),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Proceed to sign in',
              onPressed: () => context.go(RouteNames.login),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Back',
              variant: AppButtonVariant.text,
              onPressed: () => context.go(RouteNames.onboardingPrivacy),
            ),
          ],
        ),
      ),
    );
  }
}
