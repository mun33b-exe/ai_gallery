import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../utils/responsive.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<_NavItem> _navItems = [
    _NavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long_rounded,
      label: 'Bills',
    ),
    _NavItem(
      icon: Icons.swap_horiz_rounded,
      selectedIcon: Icons.swap_horiz_rounded,
      label: 'Activity',
      secondaryLabel: 'Transactions',
    ),
    _NavItem(
      icon: Icons.auto_awesome_outlined,
      selectedIcon: Icons.auto_awesome_rounded,
      label: 'Lens',
      secondaryLabel: 'Ask AI',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = Responsive.horizontalPadding(context);
    final navHeight = Responsive.spacing(context, 64, min: 58, max: 70);
    final borderRadius = Responsive.spacing(context, 22, min: 18, max: 26);
    final iconSize = Responsive.iconSize(
      context,
      designSize: 22,
      min: 20,
      max: 26,
    );
    final fontSize = Responsive.fontSize(
      context,
      designSize: 11,
      min: 10,
      max: 13,
    );

    final safeBottomInset = Responsive.safeBottom(context);
    final bottomMargin = safeBottomInset > 0
        ? safeBottomInset + Responsive.spacing(context, 4, min: 2, max: 8)
        : Responsive.spacing(context, 12, min: 8, max: 16);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.15),
                Colors.white.withValues(alpha: 0.70),
              ],
            ),
          ),
          padding: EdgeInsets.only(
            left: horizontalMargin,
            right: horizontalMargin,
            top: Responsive.spacing(context, 8, min: 6, max: 12),
            bottom: bottomMargin,
          ),
          child: Container(
            height: navHeight,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.85),
                width: 1.2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A101828), // 10% soft black
                  blurRadius: 28,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Color(0x0A101828), // 4% ambient black
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = index == currentIndex;

                return Expanded(
                  child: Semantics(
                    button: true,
                    selected: isSelected,
                    label: '${item.label} tab',
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onTap(index),
                        borderRadius: BorderRadius.circular(borderRadius),
                        splashColor: AppColors.primaryGreenLight,
                        highlightColor: Colors.transparent,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.spacing(
                                    context,
                                    10,
                                    min: 8,
                                    max: 14,
                                  ),
                                  vertical: Responsive.spacing(
                                    context,
                                    3,
                                    min: 2,
                                    max: 5,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryGreenLight
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    Responsive.spacing(context, 12),
                                  ),
                                ),
                                child: Icon(
                                  isSelected ? item.selectedIcon : item.icon,
                                  size: iconSize,
                                  color: isSelected
                                      ? AppColors.primaryGreenDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: Responsive.spacing(context, 2)),
                              Text(
                                item.label,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: fontSize,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.primaryGreenDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.secondaryLabel,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String? secondaryLabel;
}
