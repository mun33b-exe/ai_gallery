import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/services/supabase_service.dart';
import 'features/auth/data/supabase_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely initialize Supabase. Does not crash if credentials are not provided via --dart-define.
  await SupabaseService.instance.initialize();

  final authRepository = SupabaseAuthRepository(
    supabaseService: SupabaseService.instance,
  );

  runApp(GalleryFinanceApp(authRepository: authRepository));
}
