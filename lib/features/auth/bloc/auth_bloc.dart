import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    on<AuthSessionStarted>(_onSessionStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthSignupRequested>(_onSignupRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onUserChanged);

    _authSubscription = authRepository.authStateChanges.listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final AuthRepository authRepository;
  StreamSubscription? _authSubscription;

  Future<void> _onSessionStarted(
    AuthSessionStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final user = authRepository.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await authRepository.logInWithEmail(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } on AppException catch (e) {
      emit(AuthFailure(e.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure('Login failed: ${e.toString()}'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignupRequested(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await authRepository.signUpWithEmail(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      emit(AuthAuthenticated(user));
    } on AppException catch (e) {
      emit(AuthFailure(e.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure('Signup failed: ${e.toString()}'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await authRepository.logOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure('Logout failed: ${e.toString()}'));
      emit(const AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
