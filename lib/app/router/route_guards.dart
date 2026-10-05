import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/bloc/auth_state.dart';
import 'route_names.dart';

/// Adapts a Dart [Stream] into a Flutter [Listenable] for GoRouter's refreshListenable.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Central routing guard deciding navigation redirects based on authentication state.
String? authRedirectGuard(
  BuildContext context,
  GoRouterState state,
  AuthBloc authBloc,
) {
  final authState = authBloc.state;
  final location = state.uri.path;

  final isAuthRoute =
      location == RouteNames.login || location == RouteNames.signup;
  final isOnboardingRoute = location.startsWith('/onboarding');
  final isAppRoute = location.startsWith('/app');
  final isRootOrSplash = location == '/' || location == RouteNames.splash;

  // If user is authenticated
  if (authState is AuthAuthenticated) {
    if (isAuthRoute || isRootOrSplash || isOnboardingRoute) {
      return RouteNames.home;
    }
    return null;
  }

  // If user is unauthenticated
  if (authState is AuthUnauthenticated) {
    if (isAppRoute) {
      return RouteNames.login;
    }
    if (isRootOrSplash) {
      return RouteNames.onboardingWelcome;
    }
    return null;
  }

  // If still initializing
  if (authState is AuthInitial) {
    if (isRootOrSplash) {
      return null;
    }
  }

  return null;
}
