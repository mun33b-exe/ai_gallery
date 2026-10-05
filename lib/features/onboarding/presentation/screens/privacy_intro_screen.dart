import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/onboarding_feature_row.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_step_indicator.dart';

class PrivacyIntroScreen extends StatelessWidget {
  const PrivacyIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.go(RouteNames.onboardingWelcome),
        ),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            const Spacer(),
            const OnboardingHeader(
              icon: AppIcons.privacy,
              title: 'Your privacy comes first',
              description: 'We treat your financial documents with strict boundaries and privacy controls.',
            ),
            const SizedBox(height: AppSpacing.xxl),
            const OnboardingFeatureRow(
              icon: Icons.lock_outline_rounded,
              title: 'Scoped processing',
              description:
                  'Documents are analyzed strictly for financial parameters.',
            ),
            const OnboardingFeatureRow(
              icon: Icons.shield_outlined,
              title: 'Explicit consent',
              description: 'You control which images or folders are processed.',
            ),
            const OnboardingFeatureRow(
              icon: Icons.delete_outline_rounded,
              title: 'Full data control',
              description:
                  'Delete your metadata or stored records at any moment.',
            ),
            const Spacer(),
            const OnboardingStepIndicator(currentStep: 1),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Continue',
              onPressed: () => context.go(RouteNames.onboardingPhotoAccess),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Back',
              variant: AppButtonVariant.text,
              onPressed: () => context.go(RouteNames.onboardingWelcome),
            ),
          ],
        ),
      ),
    );
  }
}
