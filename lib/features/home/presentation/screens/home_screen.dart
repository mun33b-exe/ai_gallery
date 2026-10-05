import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading_state.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_section_title.dart';
import '../../cubit/dashboard_cubit.dart';
import '../../cubit/dashboard_state.dart';
import '../widgets/ask_ai_card.dart';
import '../widgets/data_freshness_row.dart';
import '../widgets/finance_feature_grid.dart';
import '../widgets/financial_summary_card.dart';
import '../widgets/home_header.dart';
import '../widgets/review_needed_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardInitial) {
          context.read<DashboardCubit>().loadDashboard();
          return const AppScaffold(
            showBlueprintBanner: true,
            body: AppLoadingState(
              message: 'Loading your financial blueprint...',
            ),
          );
        }

        if (state is DashboardLoading) {
          return const AppScaffold(
            showBlueprintBanner: true,
            body: AppLoadingState(message: 'Loading financial summary...'),
          );
        }

        if (state is DashboardError) {
          return AppScaffold(
            showBlueprintBanner: true,
            body: AppErrorState(
              message: state.message,
              onRetry: () => context.read<DashboardCubit>().refresh(),
            ),
          );
        }

        if (state is DashboardLoaded) {
          final summary = state.summary;

          return AppScaffold(
            showBlueprintBanner: true,
            body: RefreshIndicator(
              onRefresh: () => context.read<DashboardCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HomeHeader(
                      userName: summary.userName,
                      userInitials: summary.userInitials,
                      onProfileTap: () => context.go(RouteNames.more),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    FinancialSummaryCard(summary: summary),
                    const SizedBox(height: AppSpacing.md),

                    DataFreshnessRow(
                      freshnessText: summary.dataFreshnessText,
                      onRefresh: () => context.read<DashboardCubit>().refresh(),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    if (summary.reviewNeededCount > 0) ...[
                      ReviewNeededRow(
                        count: summary.reviewNeededCount,
                        message: summary.reviewNeededText,
                        onTap: () => context.go(RouteNames.bills),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    AskAiCard(onTap: () => context.go(RouteNames.ai)),
                    const SizedBox(height: AppSpacing.xl),

                    AppSectionTitle(
                      title: 'Explore your finances',
                      subtitle: 'Categorized documents and smart extractions',
                      actionLabel: 'View all',
                      onActionTap: () => context.go(RouteNames.transactions),
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    const FinanceFeatureGrid(),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
