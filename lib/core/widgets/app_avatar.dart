import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.initials = 'MR',
    this.size = 40,
    this.onTap,
    this.backgroundColor = AppColors.primaryGreenLight,
    this.textColor = AppColors.primaryGreenDark,
  });

  final String initials;
  final double size;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: AppTypography.labelLarge.copyWith(
          color: textColor,
          fontSize: size * 0.38,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: avatar,
      );
    }

    return avatar;
  }
}
