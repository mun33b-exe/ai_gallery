import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gallery/core/utils/responsive.dart';

void main() {
  Widget buildTestScaffold({
    required Size size,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets viewInsets = EdgeInsets.zero,
    TextScaler textScaler = TextScaler.noScaling,
    required Widget Function(BuildContext context) builder,
  }) {
    return MediaQuery(
      data: MediaQueryData(
        size: size,
        padding: padding,
        viewInsets: viewInsets,
        textScaler: textScaler,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(builder: builder),
      ),
    );
  }

  group('Responsive Breakpoint & Device Classification Tests', () {
    testWidgets('320x568 is classified as compact and portrait', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(320, 568),
          builder: (context) {
            expect(Responsive.isCompact(context), isTrue);
            expect(Responsive.isNormal(context), isFalse);
            expect(Responsive.isLarge(context), isFalse);
            expect(Responsive.isTablet(context), isFalse);
            expect(Responsive.isPortrait(context), isTrue);
            expect(Responsive.isLandscape(context), isFalse);
            expect(
              Responsive.orientationType(context),
              DeviceOrientationType.portrait,
            );
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('375x667 is classified as normal phone', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(375, 667),
          builder: (context) {
            expect(Responsive.isCompact(context), isFalse);
            expect(Responsive.isNormal(context), isTrue);
            expect(Responsive.isLarge(context), isFalse);
            expect(Responsive.isTablet(context), isFalse);
            expect(Responsive.isPortrait(context), isTrue);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('440x956 matches Figma reference frame', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(440, 956),
          builder: (context) {
            expect(Responsive.width(context), 440.0);
            expect(Responsive.height(context), 956.0);
            expect(Responsive.isNormal(context), isTrue);
            expect(Responsive.isTablet(context), isFalse);

            // Exactly at reference width, scale should be 1.0 * designValue
            expect(Responsive.widthScale(context, 100.0), closeTo(100.0, 0.01));
            expect(
              Responsive.heightScale(context, 100.0),
              closeTo(100.0, 0.01),
            );
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('768x1024 is classified as tablet & large', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(768, 1024),
          builder: (context) {
            expect(Responsive.isCompact(context), isFalse);
            expect(Responsive.isNormal(context), isFalse);
            expect(Responsive.isLarge(context), isTrue);
            expect(Responsive.isTablet(context), isTrue);
            expect(Responsive.isPortrait(context), isTrue);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('1024x768 is classified as extra-large & landscape', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(1024, 768),
          builder: (context) {
            expect(Responsive.isExtraLarge(context), isTrue);
            expect(Responsive.isTablet(context), isTrue);
            expect(Responsive.isLandscape(context), isTrue);
            expect(Responsive.isPortrait(context), isFalse);
            expect(
              Responsive.orientationType(context),
              DeviceOrientationType.landscape,
            );
            return const SizedBox();
          },
        ),
      );
    });
  });

  group('Safe Area and Insets Tests', () {
    testWidgets('Safe area helpers return non-negative values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(390, 844),
          padding: const EdgeInsets.only(top: 47, bottom: 34),
          viewInsets: const EdgeInsets.only(bottom: 280),
          builder: (context) {
            expect(Responsive.safeTop(context), 47.0);
            expect(Responsive.safeBottom(context), 34.0);
            expect(Responsive.keyboardBottomInset(context), 280.0);

            final safePadding = Responsive.safeHorizontalPadding(context);
            expect(safePadding.left, greaterThanOrEqualTo(0.0));
            expect(safePadding.right, greaterThanOrEqualTo(0.0));
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('Safe area helpers gracefully handle zero insets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(360, 640),
          padding: EdgeInsets.zero,
          viewInsets: EdgeInsets.zero,
          builder: (context) {
            expect(Responsive.safeTop(context), 0.0);
            expect(Responsive.safeBottom(context), 0.0);
            expect(Responsive.keyboardBottomInset(context), 0.0);
            return const SizedBox();
          },
        ),
      );
    });
  });

  group('Scaling and Dimension Clamping Tests', () {
    testWidgets('Scale values are strictly clamped', (
      WidgetTester tester,
    ) async {
      // Very wide screen: 1400px
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(1400, 900),
          builder: (context) {
            // maxFactor is 1.08 by default for widthScale
            final scaled = Responsive.widthScale(context, 100.0);
            expect(scaled, closeTo(108.0, 0.01));

            // Custom min and max clamping
            final customClamped = Responsive.scale(
              context,
              100.0,
              min: 50.0,
              max: 105.0,
            );
            expect(customClamped, 105.0);
            return const SizedBox();
          },
        ),
      );

      // Very small screen: 200px
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(200, 400),
          builder: (context) {
            // minFactor is 0.88 by default for widthScale
            final scaled = Responsive.widthScale(context, 100.0);
            expect(scaled, closeTo(88.0, 0.01));
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('Common dimensions return valid values for all screen sizes', (
      WidgetTester tester,
    ) async {
      const testSizes = [
        Size(320, 568),
        Size(375, 667),
        Size(390, 844),
        Size(440, 956),
        Size(768, 1024),
        Size(1024, 768),
      ];

      for (final s in testSizes) {
        await tester.pumpWidget(
          buildTestScaffold(
            size: s,
            builder: (context) {
              expect(Responsive.horizontalPadding(context), greaterThan(0.0));
              expect(Responsive.sectionSpacing(context), greaterThan(0.0));
              expect(Responsive.cardRadius(context), greaterThan(0.0));
              expect(
                Responsive.fontSize(context, designSize: 16),
                greaterThan(0.0),
              );
              expect(
                Responsive.iconSize(context, designSize: 24),
                greaterThan(0.0),
              );
              expect(Responsive.spacing(context, 12), greaterThan(0.0));
              return const SizedBox();
            },
          ),
        );
      }
    });
  });

  group('Breakpoint Value Selection & Fallback Tests', () {
    testWidgets('Responsive.value uses fallback chain correctly', (
      WidgetTester tester,
    ) async {
      // Compact width (320)
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(320, 568),
          builder: (context) {
            final val = Responsive.value<int>(
              context,
              compact: 1,
              normal: 2,
              large: 3,
            );
            expect(val, 1);
            return const SizedBox();
          },
        ),
      );

      // Normal width (400) fallback when normal is null
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(400, 800),
          builder: (context) {
            final val = Responsive.value<int>(context, compact: 10, large: 30);
            // Should fallback to compact when normal is not provided
            expect(val, 10);
            return const SizedBox();
          },
        ),
      );

      // Large width (700)
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(700, 900),
          builder: (context) {
            final val = Responsive.value<int>(
              context,
              compact: 1,
              normal: 2,
              large: 3,
            );
            expect(val, 3);
            return const SizedBox();
          },
        ),
      );

      // Orientation value selection
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(800, 400), // landscape
          builder: (context) {
            final val = Responsive.orientationValue<String>(
              context,
              portrait: 'P',
              landscape: 'L',
            );
            expect(val, 'L');
            return const SizedBox();
          },
        ),
      );
    });
  });

  group('Typography and Accessibility Tests', () {
    testWidgets('Effective text scale factor is extracted correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestScaffold(
          size: const Size(390, 844),
          textScaler: const TextScaler.linear(1.5),
          builder: (context) {
            expect(Responsive.effectiveTextScale(context), closeTo(1.5, 0.01));
            expect(Responsive.textScaler(context), isNotNull);
            return const SizedBox();
          },
        ),
      );
    });
  });

  group('ResponsiveBuilder Widget Tests', () {
    testWidgets('ResponsiveBuilder supplies layout constraints correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                height: 200,
                child: ResponsiveBuilder(
                  builder: (context, constraints) {
                    return Text(
                      'W:${constraints.maxWidth.toInt()},H:${constraints.maxHeight.toInt()}',
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('W:300,H:200'), findsOneWidget);
    });
  });
}
