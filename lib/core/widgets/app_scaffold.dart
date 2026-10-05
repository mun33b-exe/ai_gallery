import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../constants/app_constants.dart';

/// Reusable application scaffold with consistent background, safe area,
/// and optional design blueprint indicator banner.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor = AppColors.background,
    this.showBlueprintBanner = false,
    this.padding,
    this.useSafeArea = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color backgroundColor;
  final bool showBlueprintBanner;
  final EdgeInsetsGeometry? padding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (showBlueprintBanner) {
      content = Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xs,
            ),
            color: AppColors.primaryGreenLight,
            child: Text(
              AppConstants.blueprintBanner,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.primaryGreenDark,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: content),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: useSafeArea ? SafeArea(child: content) : content,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
