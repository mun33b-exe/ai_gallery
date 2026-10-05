import 'package:flutter/foundation.dart';

import '../domain/auth_user.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

/// Dispatched upon application launch to inspect active credentials/session.
final class AuthSessionStarted extends AuthEvent {
  const AuthSessionStarted();
}

/// Dispatched when the user submits email/password credentials to log in.
final class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

/// Dispatched when the user registers a new account.
final class AuthSignupRequested extends AuthEvent {
  const AuthSignupRequested({
    required this.email,
    required this.password,
    this.name,
  });

  final String email;
  final String password;
  final String? name;
}

/// Dispatched when user triggers logout.
final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Dispatched internally when the auth repository stream emits a user change.
final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final AuthUser? user;
}
