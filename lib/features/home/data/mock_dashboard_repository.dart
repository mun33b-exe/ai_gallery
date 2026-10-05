import '../../../core/constants/app_constants.dart';
import '../../../core/constants/mock_constants.dart';
import '../domain/dashboard_summary.dart';

abstract class DashboardRepository {
  Future<DashboardSummary> fetchDashboardSummary();
}

class MockDashboardRepository implements DashboardRepository {
  const MockDashboardRepository();

  @override
  Future<DashboardSummary> fetchDashboardSummary() async {
    // Simulate brief local load
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return const DashboardSummary(
      userName: AppConstants.defaultUserName,
      userInitials: AppConstants.defaultUserInitials,
      periodLabel: MockConstants.mockPeriodLabel,
      spentAmount: MockConstants.mockSpent,
      receivedAmount: MockConstants.mockReceived,
      currency: MockConstants.mockCurrency,
      dataFreshnessText: MockConstants.mockDataFreshness,
      reviewNeededCount: MockConstants.mockReviewNeededCount,
      reviewNeededText: MockConstants.mockReviewNeededText,
    );
  }
}
