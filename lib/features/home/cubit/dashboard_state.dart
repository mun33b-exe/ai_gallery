import 'package:flutter/foundation.dart';

import '../domain/dashboard_summary.dart';

@immutable
sealed class DashboardState {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.summary);

  final DashboardSummary summary;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardLoaded &&
          runtimeType == other.runtimeType &&
          summary == other.summary;

  @override
  int get hashCode => summary.hashCode;
}

final class DashboardError extends DashboardState {
  const DashboardError(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
