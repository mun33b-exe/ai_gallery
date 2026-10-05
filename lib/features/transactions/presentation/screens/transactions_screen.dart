import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_icons.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/transaction_list_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  static final List<Map<String, dynamic>> mockTransactions = [
    {
      'id': 'tx-101',
      'merchant': 'Metro Supermarket',
      'category': 'Groceries',
      'date': DateTime.now().subtract(const Duration(hours: 3)),
      'amount': 1850.0,
      'isExpense': true,
    },
    {
      'id': 'tx-102',
      'merchant': 'Client Retainer Payment',
      'category': 'Income',
      'date': DateTime.now().subtract(const Duration(hours: 8)),
      'amount': 4000.0,
      'isExpense': false,
    },
    {
      'id': 'tx-103',
      'merchant': 'Shell Fuel Station',
      'category': 'Transport',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'amount': 1200.0,
      'isExpense': true,
    },
    {
      'id': 'tx-104',
      'merchant': 'Cloud Hosting Subscription',
      'category': 'Utilities',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'amount': 950.0,
      'isExpense': true,
    },
    {
      'id': 'tx-105',
      'merchant': 'Pharmacy Healthcare',
      'category': 'Health',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'amount': 1000.0,
      'isExpense': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.filter),
            tooltip: 'Filter transactions',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: mockTransactions.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppColors.border,
          height: 1,
          indent: AppSpacing.screenMargin,
          endIndent: AppSpacing.screenMargin,
        ),
        itemBuilder: (context, index) {
          final tx = mockTransactions[index];
          return TransactionListItem(
            id: tx['id'] as String,
            merchant: tx['merchant'] as String,
            category: tx['category'] as String,
            date: tx['date'] as DateTime,
            amount: tx['amount'] as double,
            isExpense: tx['isExpense'] as bool,
            onTap: () => context.go('${RouteNames.transactions}/${tx['id']}'),
          );
        },
      ),
    );
  }
}
