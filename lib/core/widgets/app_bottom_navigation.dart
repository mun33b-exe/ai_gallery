import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_icons.dart';
import '../../app/theme/app_shadows.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: AppShadows.bottomNav,
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: AppColors.surface,
        destinations: const [
          NavigationDestination(
            icon: Icon(AppIcons.navHomeOutline),
            selectedIcon: Icon(AppIcons.navHome),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(AppIcons.navBillsOutline),
            selectedIcon: Icon(AppIcons.navBills),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(AppIcons.navTransactionsOutline),
            selectedIcon: Icon(AppIcons.navTransactions),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(AppIcons.navAiOutline),
            selectedIcon: Icon(AppIcons.navAi),
            label: 'Ask AI',
          ),
        ],
      ),
    );
  }
}
