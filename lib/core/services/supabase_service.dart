import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service managing Supabase client initialization safely.
/// Protects against crashes when credentials are not supplied via --dart-define.
class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  static const String _envUrl = String.fromEnvironment('SUPABASE_URL');
  static const String _envAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  bool _isConfigured = false;
  bool _isInitialized = false;

  /// Whether Supabase environment credentials were provided and initialized.
  bool get isConfigured => _isConfigured;

  /// Whether initialize has been invoked.
  bool get isInitialized => _isInitialized;

  /// Get the Supabase client if configured, otherwise null.
  SupabaseClient? get client {
    if (_isConfigured && _isInitialized) {
      return Supabase.instance.client;
    }
    return null;
  }

  /// Initializes Supabase safely. Does not throw or crash if configuration is absent.
  Future<void> initialize() async {
    if (_isInitialized) return;

    final hasUrl = _envUrl.trim().isNotEmpty;
    final hasKey = _envAnonKey.trim().isNotEmpty;

    if (!hasUrl || !hasKey) {
      _isConfigured = false;
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint(
          '[SupabaseService] SUPABASE_URL or SUPABASE_ANON_KEY not provided via --dart-define. '
          'Running safely in design blueprint / demo mode.',
        );
      }
      return;
    }

    try {
      await Supabase.initialize(
        url: _envUrl.trim(),
        // ignore: deprecated_member_use
        anonKey: _envAnonKey.trim(),
      );
      _isConfigured = true;
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint(
          '[SupabaseService] Initialized successfully with remote backend.',
        );
      }
    } catch (e) {
      _isConfigured = false;
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint(
          '[SupabaseService] Failed to initialize Supabase: $e. Falling back to demo mode.',
        );
      }
    }
  }
}
