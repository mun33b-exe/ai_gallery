import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/mock_dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({DashboardRepository? repository})
    : _repository = repository ?? const MockDashboardRepository(),
      super(const DashboardInitial());

  final DashboardRepository _repository;

  Future<void> loadDashboard() async {
    emit(const DashboardLoading());
    try {
      final summary = await _repository.fetchDashboardSummary();
      emit(DashboardLoaded(summary));
    } catch (e) {
      emit(DashboardError('Failed to load dashboard: ${e.toString()}'));
    }
  }

  Future<void> refresh() => loadDashboard();
}
