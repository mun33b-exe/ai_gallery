import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gallery/features/subscriptions/presentation/screens/subscriptions_screen.dart';

void main() {
  testWidgets('SubscriptionsScreen renders platform-specific back button', (
    WidgetTester tester,
  ) async {
    // 1. Test iOS
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        home: const SubscriptionsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Subscriptions'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    // 2. Test Android
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.android),
        home: const SubscriptionsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Subscriptions'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });
}
