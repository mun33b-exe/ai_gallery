/// Central definition of all route paths and route names across the application.
abstract final class RouteNames {
  static const String initial = '/';
  static const String splash = '/splash';

  // Onboarding
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingPrivacy = '/onboarding/privacy';
  static const String onboardingPhotoAccess = '/onboarding/photo-access';

  // Authentication
  static const String login = '/login';
  static const String signup = '/signup';

  // App Shell routes
  static const String appShell = '/app';
  static const String home = '/app/home';
  static const String bills = '/app/bills';
  static const String transactions = '/app/transactions';
  static const String ai = '/app/ai';
  static const String subscriptions = '/app/subscriptions';
  static const String more = '/app/more';

  // Secondary sub-routes
  static const String transactionDetails = '/app/transactions/:id';
  static const String settingsPrivacy = '/app/settings/privacy';
  static const String settingsData = '/app/settings/data';
  static const String settingsAccount = '/app/settings/account';
}
