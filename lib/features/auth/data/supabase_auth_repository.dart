import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/mock_constants.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/services/supabase_service.dart';
import '../domain/auth_user.dart';
import 'auth_repository.dart';

/// Implementation of [AuthRepository] backed by Supabase with safe fallback
/// to demo mock auth when Supabase credentials are not provided.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({SupabaseService? supabaseService})
    : _supabaseService = supabaseService ?? SupabaseService.instance {
    _init();
  }

  final SupabaseService _supabaseService;
  final StreamController<AuthUser?> _authStateController =
      StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;
  StreamSubscription<supa.AuthState>? _supaSubscription;

  void _init() {
    if (_supabaseService.isConfigured && _supabaseService.client != null) {
      final supaClient = _supabaseService.client!;
      final initialUser = supaClient.auth.currentUser;
      if (initialUser != null) {
        _currentUser = _mapSupaUser(initialUser);
      }

      _supaSubscription = supaClient.auth.onAuthStateChange.listen((data) {
        final user = data.session?.user;
        _currentUser = user != null ? _mapSupaUser(user) : null;
        _authStateController.add(_currentUser);
      });
    } else {
      // In unconfigured / blueprint preview mode, start with the demo user
      // so reviewers can immediately see the authenticated app shell.
      _currentUser = const AuthUser(
        id: 'demo-user-id',
        email: MockConstants.mockDemoEmail,
        name: AppConstants.defaultUserName,
      );
    }
  }

  @override
  bool get isConfigured => _supabaseService.isConfigured;

  @override
  Stream<AuthUser?> get authStateChanges async* {
    yield _currentUser;
    yield* _authStateController.stream;
  }

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Future<AuthUser> logInWithEmail({
    required String email,
    required String password,
  }) async {
    if (_supabaseService.isConfigured && _supabaseService.client != null) {
      try {
        final response = await _supabaseService.client!.auth.signInWithPassword(
          email: email.trim(),
          password: password,
        );
        final user = response.user;
        if (user == null) {
          throw const AuthAppException('Login failed: user data missing');
        }
        final authUser = _mapSupaUser(user);
        _currentUser = authUser;
        _authStateController.add(_currentUser);
        return authUser;
      } on supa.AuthException catch (e) {
        throw AuthAppException(e.message, code: e.statusCode);
      } catch (e) {
        throw AuthAppException(
          'An unexpected authentication error occurred: $e',
        );
      }
    } else {
      // Safe demo mock login
      await Future<void>.delayed(const Duration(milliseconds: 600));
      final authUser = AuthUser(
        id: 'demo-user-id',
        email: email.trim(),
        name: email.contains('muneeb')
            ? AppConstants.defaultUserName
            : 'Demo User',
      );
      _currentUser = authUser;
      _authStateController.add(_currentUser);
      return authUser;
    }
  }

  @override
  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    if (_supabaseService.isConfigured && _supabaseService.client != null) {
      try {
        final response = await _supabaseService.client!.auth.signUp(
          email: email.trim(),
          password: password,
          data: name != null ? {'full_name': name} : null,
        );
        final user = response.user;
        if (user == null) {
          throw const AuthAppException('Signup failed: user data missing');
        }
        final authUser = _mapSupaUser(user);
        _currentUser = authUser;
        _authStateController.add(_currentUser);
        return authUser;
      } on supa.AuthException catch (e) {
        throw AuthAppException(e.message, code: e.statusCode);
      } catch (e) {
        throw AuthAppException('An unexpected signup error occurred: $e');
      }
    } else {
      // Safe demo mock signup
      await Future<void>.delayed(const Duration(milliseconds: 600));
      final authUser = AuthUser(
        id: 'demo-user-id',
        email: email.trim(),
        name: name ?? AppConstants.defaultUserName,
      );
      _currentUser = authUser;
      _authStateController.add(_currentUser);
      return authUser;
    }
  }

  @override
  Future<void> logOut() async {
    if (_supabaseService.isConfigured && _supabaseService.client != null) {
      try {
        await _supabaseService.client!.auth.signOut();
      } catch (e) {
        // Fallback clear
      }
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
    _currentUser = null;
    _authStateController.add(null);
  }

  AuthUser _mapSupaUser(supa.User user) {
    final meta = user.userMetadata;
    final fullName = meta != null && meta['full_name'] != null
        ? meta['full_name'].toString()
        : null;

    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      name: fullName,
      isAnonymous: user.isAnonymous,
    );
  }

  void dispose() {
    _supaSubscription?.cancel();
    _authStateController.close();
  }
}
