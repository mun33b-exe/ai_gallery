import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_bottom_navigation.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../features/ai_assistant/presentation/screens/ai_assistant_screen.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/bills/presentation/screens/bills_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/photo_access_preview_screen.dart';
import '../../features/onboarding/presentation/screens/privacy_intro_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/settings/presentation/screens/account_settings_screen.dart';
import '../../features/settings/presentation/screens/data_management_screen.dart';
import '../../features/settings/presentation/screens/more_screen.dart';
import '../../features/settings/presentation/screens/privacy_settings_screen.dart';
import '../../features/subscriptions/presentation/screens/subscriptions_screen.dart';
import '../../features/transactions/presentation/screens/transaction_details_screen.dart';
import '../../features/transactions/presentation/screens/transactions_screen.dart';
import 'route_guards.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.home,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) => authRedirectGuard(context, state, authBloc),
    routes: [
      // Splash screen
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const _SplashScreen(),
      ),

      // Onboarding routes
      GoRoute(
        path: RouteNames.onboardingWelcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.onboardingPrivacy,
        builder: (context, state) => const PrivacyIntroScreen(),
      ),
      GoRoute(
        path: RouteNames.onboardingPhotoAccess,
        builder: (context, state) => const PhotoAccessPreviewScreen(),
      ),

      // Auth routes
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),

      // Stateful shell for persistent bottom navigation (Home | Bills | Transactions | AI)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: AppBottomNavigation(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            ),
          );
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Branch 1: Bills
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.bills,
                builder: (context, state) => const BillsScreen(),
              ),
            ],
          ),
          // Branch 2: Transactions
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.transactions,
                builder: (context, state) => const TransactionsScreen(),
              ),
            ],
          ),
          // Branch 3: Ask AI
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ai,
                builder: (context, state) => const AiAssistantScreen(),
              ),
            ],
          ),
        ],
      ),

      // Secondary screens outside bottom nav shell
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.subscriptions,
        builder: (context, state) => const SubscriptionsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.more,
        builder: (context, state) => const MoreScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.transactionDetails,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'unknown';
          return TransactionDetailsScreen(transactionId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.settingsPrivacy,
        builder: (context, state) => const PrivacySettingsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.settingsData,
        builder: (context, state) => const DataManagementScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.settingsAccount,
        builder: (context, state) => const AccountSettingsScreen(),
      ),
    ],
  );
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(body: Center(child: CircularProgressIndicator()));
  }
}
