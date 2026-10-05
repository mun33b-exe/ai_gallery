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

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            const Spacer(),
            const OnboardingHeader(
              icon: Icons.account_balance_wallet_rounded,
              title: 'Welcome to\nGallery Finance AI',
              description: 'Turn receipts, invoices, and payment screenshots into structured financial clarity.',
            ),
            const SizedBox(height: AppSpacing.xxl),
            const OnboardingFeatureRow(
              icon: AppIcons.bills,
              title: 'Visual extraction blueprint',
              description: 'Designed to capture financial data from everyday photos and documents.',
            ),
            const OnboardingFeatureRow(
              icon: AppIcons.askAi,
              title: 'Conversational assistant',
              description: 'Ask questions about your monthly spending in plain natural language.',
            ),
            const OnboardingFeatureRow(
              icon: AppIcons.privacy,
              title: 'Private & secure',
              description:
                  'Architecture built around user data ownership and security.',
            ),
            const Spacer(),
            const OnboardingStepIndicator(currentStep: 0),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Get started',
              onPressed: () => context.go(RouteNames.onboardingPrivacy),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Skip to sign in',
              variant: AppButtonVariant.text,
              onPressed: () => context.go(RouteNames.login),
            ),
          ],
        ),
      ),
    );
  }
}
