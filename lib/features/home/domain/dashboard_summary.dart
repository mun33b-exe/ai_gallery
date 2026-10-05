/// Domain model holding summarized financial numbers and status for the home screen.
class DashboardSummary {
  const DashboardSummary({
    required this.userName,
    required this.userInitials,
    required this.periodLabel,
    required this.spentAmount,
    required this.receivedAmount,
    required this.currency,
    required this.dataFreshnessText,
    required this.reviewNeededCount,
    required this.reviewNeededText,
  });

  final String userName;
  final String userInitials;
  final String periodLabel;
  final double spentAmount;
  final double receivedAmount;
  final String currency;
  final String dataFreshnessText;
  final int reviewNeededCount;
  final String reviewNeededText;

  double get netBalance => receivedAmount - spentAmount;
  double get totalVolume => spentAmount + receivedAmount;
  double get spentRatio => totalVolume > 0 ? (spentAmount / totalVolume) : 0.5;
  double get receivedRatio =>
      totalVolume > 0 ? (receivedAmount / totalVolume) : 0.5;
}
