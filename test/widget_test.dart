import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gallery/app/app.dart';
import 'package:ai_gallery/features/auth/data/supabase_auth_repository.dart';
import 'package:ai_gallery/features/home/data/mock_dashboard_repository.dart';

void main() {
  testWidgets('GalleryFinanceApp smoke test loads blueprint home screen', (
    WidgetTester tester,
  ) async {
    final authRepository = SupabaseAuthRepository();
    const dashboardRepository = MockDashboardRepository();

    await tester.pumpWidget(
      GalleryFinanceApp(
        authRepository: authRepository,
        dashboardRepository: dashboardRepository,
      ),
    );

    // Let the initial frame and routing settle
    await tester.pumpAndSettle();

    // Verify counter is not present (old demo removed)
    expect(
      find.text('You have pushed the button this many times:'),
      findsNothing,
    );

    // Verify home screen blueprint elements
    expect(find.text('Muneeb Ur Rehman'), findsWidgets);
    expect(find.text('Explore your finances'), findsOneWidget);
    expect(find.text('Bills & Receipts'), findsOneWidget);
    expect(find.text('Subscriptions'), findsOneWidget);
    expect(find.text('Ask AI Assistant'), findsOneWidget);
  });
}
