import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/bloc/auth_event.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/home/cubit/dashboard_cubit.dart';
import '../features/home/data/mock_dashboard_repository.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class GalleryFinanceApp extends StatefulWidget {
  const GalleryFinanceApp({
    super.key,
    required this.authRepository,
    this.dashboardRepository = const MockDashboardRepository(),
  });

  final AuthRepository authRepository;
  final DashboardRepository dashboardRepository;

  @override
  State<GalleryFinanceApp> createState() => _GalleryFinanceAppState();
}

class _GalleryFinanceAppState extends State<GalleryFinanceApp> {
  late final AuthBloc _authBloc;
  late final DashboardCubit _dashboardCubit;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(authRepository: widget.authRepository)
      ..add(const AuthSessionStarted());
    _dashboardCubit = DashboardCubit(repository: widget.dashboardRepository);
    _router = createRouter(_authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    _dashboardCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: widget.authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: _authBloc),
          BlocProvider<DashboardCubit>.value(value: _dashboardCubit),
        ],
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
