import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gallery/features/bills/data/mock_bills_repository.dart';
import 'package:ai_gallery/features/bills/presentation/screens/bills_screen.dart';

void main() {
  Widget createTestWidget() {
    return const MaterialApp(
      home: BillsScreen(repository: MockBillsRepository()),
    );
  }

  testWidgets('BillsScreen renders Receipt Radar blueprint elements', (
    WidgetTester tester,
  ) async {
    // Provide a standard phone screen size (440 x 956)
    tester.view.physicalSize = const Size(440 * 2, 956 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // 1. Top App Bar
    expect(find.text('Receipt Radar'), findsOneWidget);

    // 2. Summary Card
    expect(find.text('Jun 2026'), findsOneWidget);
    expect(find.text('PAID OUTFLOW'), findsOneWidget);
    expect(find.text('PKR 3,010'), findsOneWidget);
    expect(find.text('SLIPS'), findsOneWidget);
    expect(find.text('1BILL Utility 50%'), findsOneWidget);
    expect(find.text('Raast P2P 50%'), findsOneWidget);

    // 4. Filter Chips
    expect(find.text('All'), findsOneWidget);
    expect(find.text('1BILL Invoices'), findsOneWidget);
    expect(find.text('Raast Transfers'), findsOneWidget);

    // 5. Receipt Cards
    expect(find.text('1BILL - Invoice'), findsOneWidget);
    expect(find.text('PAID VIA HBL'), findsOneWidget);
    expect(find.text('STAMP DETECTED'), findsOneWidget);
    expect(find.text('#1006872607'), findsOneWidget);

    expect(find.text('Raast Transfer · Javeria Amin'), findsOneWidget);
    expect(find.text('SENT VIA RAAST'), findsOneWidget);
    expect(find.text('RAAST MATCHED'), findsOneWidget);
    expect(find.text('TXN: 18422998880'), findsOneWidget);

    // 6. Footer Trust Badge
    expect(find.text('On-Device Neural Processing'), findsOneWidget);
    expect(find.text('Zero cloud uploads • Stored locally'), findsOneWidget);
  });

  testWidgets('BillsScreen category filtering updates visible receipt cards', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(440 * 2, 956 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Both receipts visible initially
    expect(find.text('1BILL - Invoice'), findsOneWidget);
    expect(find.text('Raast Transfer · Javeria Amin'), findsOneWidget);

    // Tap 1BILL Invoices filter chip
    await tester.ensureVisible(find.text('1BILL Invoices'));
    await tester.tap(find.text('1BILL Invoices'));
    await tester.pumpAndSettle();

    // Only 1BILL receipt should be displayed
    expect(find.text('1BILL - Invoice'), findsOneWidget);
    expect(find.text('Raast Transfer · Javeria Amin'), findsNothing);

    // Tap Raast Transfers filter chip
    await tester.ensureVisible(find.text('Raast Transfers'));
    await tester.tap(find.text('Raast Transfers'));
    await tester.pumpAndSettle();

    // Only Raast receipt should be displayed
    expect(find.text('1BILL - Invoice'), findsNothing);
    expect(find.text('Raast Transfer · Javeria Amin'), findsOneWidget);

    // Tap All filter chip
    await tester.ensureVisible(find.text('All'));
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    // Both receipts displayed again
    expect(find.text('1BILL - Invoice'), findsOneWidget);
    expect(find.text('Raast Transfer · Javeria Amin'), findsOneWidget);
  });

  testWidgets('BillsScreen app bar title alignment is platform specific', (
    WidgetTester tester,
  ) async {
    // 1. Test iOS: title is centered
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        home: const BillsScreen(repository: MockBillsRepository()),
      ),
    );
    await tester.pumpAndSettle();

    final iosAlignFinder = find.ancestor(
      of: find.text('Receipt Radar'),
      matching: find.byType(Align),
    );
    expect(iosAlignFinder, findsWidgets);
    final iosAlign = tester.widget<Align>(iosAlignFinder.first);
    expect(iosAlign.alignment, Alignment.center);

    final iosText = tester.widget<Text>(find.text('Receipt Radar'));
    expect(iosText.textAlign, TextAlign.center);

    // 2. Test Android: title is start-aligned (left)
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.android),
        home: const BillsScreen(repository: MockBillsRepository()),
      ),
    );
    await tester.pumpAndSettle();

    final androidAlignFinder = find.ancestor(
      of: find.text('Receipt Radar'),
      matching: find.byType(Align),
    );
    expect(androidAlignFinder, findsWidgets);
    final androidAlign = tester.widget<Align>(androidAlignFinder.first);
    expect(androidAlign.alignment, Alignment.centerLeft);

    final androidText = tester.widget<Text>(find.text('Receipt Radar'));
    expect(androidText.textAlign, TextAlign.start);
  });
}
