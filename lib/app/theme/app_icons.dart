import 'package:flutter/material.dart';

/// Central icon token definitions ensuring a single consistent icon family.
abstract final class AppIcons {
  // Navigation tabs
  static const IconData navHome = Icons.home_rounded;
  static const IconData navHomeOutline = Icons.home_outlined;
  static const IconData navBills = Icons.receipt_long_rounded;
  static const IconData navBillsOutline = Icons.receipt_long_outlined;
  static const IconData navTransactions = Icons.swap_horiz_rounded;
  static const IconData navTransactionsOutline = Icons.swap_horiz_outlined;
  static const IconData navAi = Icons.smart_toy_rounded;
  static const IconData navAiOutline = Icons.smart_toy_outlined;
  static const IconData navMore = Icons.grid_view_rounded;
  static const IconData navMoreOutline = Icons.grid_view_outlined;

  // Features and quick actions
  static const IconData askAi = Icons.chat_bubble_outline_rounded;
  static const IconData subscriptions = Icons.calendar_month_outlined;
  static const IconData bills = Icons.receipt_outlined;
  static const IconData transactions = Icons.receipt_long_outlined;
  static const IconData freshSync = Icons.sync_rounded;
  static const IconData reviewNeeded = Icons.pending_actions_rounded;
  static const IconData analytics = Icons.insights_rounded;

  // Financial status
  static const IconData incoming = Icons.arrow_downward_rounded;
  static const IconData outgoing = Icons.arrow_upward_rounded;
  static const IconData transfer = Icons.swap_horiz_rounded;

  // Settings & system
  static const IconData privacy = Icons.shield_outlined;
  static const IconData dataManagement = Icons.folder_open_rounded;
  static const IconData account = Icons.person_outline_rounded;
  static const IconData notifications = Icons.notifications_none_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData filter = Icons.tune_rounded;
  static const IconData logout = Icons.logout_rounded;
  static const IconData info = Icons.info_outline_rounded;
  static const IconData warning = Icons.warning_amber_rounded;
  static const IconData error = Icons.error_outline_rounded;
  static const IconData check = Icons.check_circle_outline_rounded;
}
