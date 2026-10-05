import '../domain/auth_user.dart';

/// Contract for authentication operations.
/// Allows swapping between SupabaseAuthRepository and mock/offline providers.
abstract class AuthRepository {
  /// Stream emitting changes to authentication state.
  Stream<AuthUser?> get authStateChanges;

  /// Returns the current authenticated user if any.
  AuthUser? get currentUser;

  /// Authenticate with email and password.
  Future<AuthUser> logInWithEmail({
    required String email,
    required String password,
  });

  /// Register new user with email and password.
  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Sign out the current user session.
  Future<void> logOut();

  /// Whether the underlying authentication service is configured with credentials.
  bool get isConfigured;
}
