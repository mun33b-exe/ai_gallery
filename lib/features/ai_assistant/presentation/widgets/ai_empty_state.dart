import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import 'suggested_prompt_chip.dart';

class AiEmptyState extends StatelessWidget {
  const AiEmptyState({super.key, required this.onPromptSelected});

  final ValueChanged<String> onPromptSelected;

  static const List<String> defaultPrompts = [
    'How much did I spend on groceries this month?',
    'Which subscriptions are due this week?',
    'Summarize all receipt payments over 1,000 PKR',
    'What was my biggest expense recently?',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryGreenLight,
              borderRadius: AppRadii.radiusXl,
            ),
            child: const Icon(
              AppIcons.navAi,
              size: 32,
              color: AppColors.primaryGreenDark,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Financial AI Assistant',
            style: AppTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Ask questions in natural language. In future phases, answers will be derived directly from your processed receipts and statements.',
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Suggested questions', style: AppTypography.labelLarge),
          ),
          const SizedBox(height: AppSpacing.md),
          ...defaultPrompts.map(
            (prompt) => SuggestedPromptChip(
              prompt: prompt,
              onTap: () => onPromptSelected(prompt),
            ),
          ),
        ],
      ),
    );
  }
}
