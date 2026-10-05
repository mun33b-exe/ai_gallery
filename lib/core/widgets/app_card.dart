import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radii.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.border,
    this.borderRadius = AppRadii.cardRadius,
    this.padding = AppSpacing.cardPadding,
    this.onTap,
    this.useShadow = false,
  });

  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool useShadow;

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1),
        boxShadow: useShadow ? AppShadows.card : null,
      ),
      padding: padding,
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(onTap: onTap, borderRadius: borderRadius, child: card),
      );
    }

    return card;
  }
}
