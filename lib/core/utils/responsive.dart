import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Orientation category for layout branching.
enum DeviceOrientationType { portrait, landscape }

/// Central responsive utility for Gallery Finance AI.
///
/// Designed around a 440 x 956 pt Figma reference frame.
/// Prevents UI overflow, text clipping, and inconsistent sizing across device form factors.
///
/// ### Core Layout Principles:
/// 1. Prefer [Expanded], [Flexible], and [Wrap] in horizontal layouts.
/// 2. Use [SingleChildScrollView] or [CustomScrollView] for vertically dynamic screens.
/// 3. Avoid putting unbounded [Column] widgets inside unconstrained scroll views.
/// 4. Use [LayoutBuilder] or [ResponsiveBuilder] when reacting to parent constraints.
/// 5. Never use absolute positioning for fluid screen components.
/// 6. Wrap top-level screen contents with [SafeArea].
/// 7. Use keyboard-aware padding for forms ([Responsive.keyboardBottomInset]).
/// 8. Avoid fixed-height containers with dynamic text.
/// 9. Constrain maximum content widths on tablets ([ConstrainedBox]).
/// 10. Always test at compact phone width (<360), normal phone, and tablet (>=600).
///
/// ### Example Usage:
/// ```dart
/// final horizontalPadding = Responsive.horizontalPadding(context);
/// final titleSize = Responsive.fontSize(context, designSize: 24, min: 22, max: 28);
/// final iconSize = Responsive.iconSize(context, designSize: 24, min: 22, max: 28);
///
/// Padding(
///   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
///   child: Row(
///     children: [
///       Icon(Icons.account_circle, size: iconSize),
///       SizedBox(width: Responsive.spacing(context, 12)),
///       Expanded(
///         child: Text(
///           'Muneeb Ur Rehman',
///           style: TextStyle(fontSize: titleSize),
///         ),
///       ),
///     ],
///   ),
/// );
///
/// final columns = Responsive.value<int>(
///   context,
///   compact: 1,
///   normal: 2,
///   large: 3,
/// );
/// ```
abstract final class Responsive {
  /// Reference frame width matching the Figma design specifications.
  static const double referenceWidth = 440.0;

  /// Reference frame height matching the Figma design specifications.
  static const double referenceHeight = 956.0;

  /// Logical-pixel breakpoint below which devices are considered compact (< 360).
  static const double compactBreakpoint = 360.0;

  /// Logical-pixel breakpoint where tablet/large devices begin (>= 600).
  static const double largeBreakpoint = 600.0;

  /// Logical-pixel breakpoint for extra-large/desktop screens (>= 840).
  static const double extraLargeBreakpoint = 840.0;

  // ---------------------------------------------------------------------------
  // Device Information
  // ---------------------------------------------------------------------------

  /// Total logical size of the display.
  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  /// Logical width of the display.
  static double width(BuildContext context) => size(context).width;

  /// Logical height of the display.
  static double height(BuildContext context) => size(context).height;

  /// Unobstructed padding for system UI notches and home indicators.
  static EdgeInsets viewPadding(BuildContext context) =>
      MediaQuery.paddingOf(context);

  /// Insets obscured by system components (such as an active on-screen keyboard).
  static EdgeInsets viewInsets(BuildContext context) =>
      MediaQuery.viewInsetsOf(context);

  /// Current display orientation.
  static Orientation orientation(BuildContext context) {
    final s = size(context);
    return s.width > s.height ? Orientation.landscape : Orientation.portrait;
  }

  /// Categorized orientation type.
  static DeviceOrientationType orientationType(BuildContext context) {
    return isLandscape(context)
        ? DeviceOrientationType.landscape
        : DeviceOrientationType.portrait;
  }

  /// Whether the screen is currently in portrait orientation.
  static bool isPortrait(BuildContext context) =>
      orientation(context) == Orientation.portrait;

  /// Whether the screen is currently in landscape orientation.
  static bool isLandscape(BuildContext context) =>
      orientation(context) == Orientation.landscape;

  /// Compact phone width (e.g. iPhone SE, smaller Androids < 360 pt).
  static bool isCompact(BuildContext context) =>
      width(context) < compactBreakpoint;

  /// Standard phone width (360 <= width < 600 pt).
  static bool isNormal(BuildContext context) {
    final w = width(context);
    return w >= compactBreakpoint && w < largeBreakpoint;
  }

  /// Large phone or mini tablet width (600 <= width < 840 pt).
  static bool isLarge(BuildContext context) {
    final w = width(context);
    return w >= largeBreakpoint && w < extraLargeBreakpoint;
  }

  /// Extra large screen or full desktop/tablet width (width >= 840 pt).
  static bool isExtraLarge(BuildContext context) =>
      width(context) >= extraLargeBreakpoint;

  /// Tablet or wider device indicator (width >= 600 pt).
  static bool isTablet(BuildContext context) =>
      width(context) >= largeBreakpoint;

  // ---------------------------------------------------------------------------
  // Safe Area & System Inset Helpers (Always Non-Negative)
  // ---------------------------------------------------------------------------

  /// Top safe area inset for notch/status bar. Guaranteed non-negative.
  static double safeTop(BuildContext context) =>
      math.max(0.0, viewPadding(context).top);

  /// Bottom safe area inset for home indicator. Guaranteed non-negative.
  static double safeBottom(BuildContext context) =>
      math.max(0.0, viewPadding(context).bottom);

  /// Height of the on-screen keyboard if open. Guaranteed non-negative.
  static double keyboardBottomInset(BuildContext context) =>
      math.max(0.0, viewInsets(context).bottom);

  /// Horizontal safe-area padding for notch cutouts in landscape.
  static EdgeInsets safeHorizontalPadding(BuildContext context) {
    final padding = viewPadding(context);
    return EdgeInsets.only(
      left: math.max(0.0, padding.left),
      right: math.max(0.0, padding.right),
    );
  }

  // ---------------------------------------------------------------------------
  // Controlled Scaling Helpers
  // ---------------------------------------------------------------------------

  /// Scales a design measurement proportionally to screen width within strict clamp limits.
  ///
  /// Prevents runaway enlargement on wide screens and extreme shrinking on small screens.
  static double widthScale(
    BuildContext context,
    double designValue, {
    double minFactor = 0.88,
    double maxFactor = 1.08,
  }) {
    final currentWidth = width(context);
    final rawFactor = currentWidth / referenceWidth;
    final clampedFactor = rawFactor.clamp(minFactor, maxFactor);
    return math.max(0.0, designValue * clampedFactor);
  }

  /// Scales a design measurement proportionally to screen height within strict clamp limits.
  static double heightScale(
    BuildContext context,
    double designValue, {
    double minFactor = 0.90,
    double maxFactor = 1.05,
  }) {
    final currentHeight = height(context);
    final rawFactor = currentHeight / referenceHeight;
    final clampedFactor = rawFactor.clamp(minFactor, maxFactor);
    return math.max(0.0, designValue * clampedFactor);
  }

  /// General controlled scale with optional absolute min and max limits.
  static double scale(
    BuildContext context,
    double designValue, {
    double? min,
    double? max,
  }) {
    final scaled = widthScale(context, designValue);
    var result = scaled;
    if (min != null) result = math.max(min, result);
    if (max != null) result = math.min(max, result);
    return math.max(0.0, result);
  }

  // ---------------------------------------------------------------------------
  // Common Responsive Dimensions
  // ---------------------------------------------------------------------------

  /// Standard horizontal screen margin (16 pt on compact, 20 pt on normal, 24 pt on tablet).
  static double horizontalPadding(BuildContext context) {
    return value<double>(
      context,
      compact: 16.0,
      normal: 20.0,
      large: 24.0,
      extraLarge: 32.0,
    );
  }

  /// Vertical section spacing between card clusters.
  static double sectionSpacing(BuildContext context) {
    return value<double>(context, compact: 16.0, normal: 20.0, large: 24.0);
  }

  /// Corner radius for cards (12 pt on compact, 16 pt on normal, 18 pt on tablet).
  static double cardRadius(BuildContext context) {
    return value<double>(context, compact: 12.0, normal: 16.0, large: 18.0);
  }

  /// Conservative icon dimension scaling.
  /// Icons should remain sharp and readable without dominating compact views.
  static double iconSize(
    BuildContext context, {
    required double designSize,
    double? min,
    double? max,
  }) {
    final defaultMin = designSize * 0.90;
    final defaultMax = designSize * 1.10;
    return scale(
      context,
      designSize,
      min: min ?? defaultMin,
      max: max ?? defaultMax,
    );
  }

  /// Conservative font size calculation.
  ///
  /// Respects visual balance without overriding system accessibility text scaling.
  /// The returned size should be assigned to [TextStyle.fontSize].
  static double fontSize(
    BuildContext context, {
    required double designSize,
    double? min,
    double? max,
  }) {
    // Keep typography tightly constrained so text never clips or overflows
    final defaultMin = designSize * 0.92;
    final defaultMax = designSize * 1.08;
    return scale(
      context,
      designSize,
      min: min ?? defaultMin,
      max: max ?? defaultMax,
    );
  }

  /// General spacing helper for margins, paddings, and [SizedBox] spacers.
  static double spacing(
    BuildContext context,
    double designValue, {
    double? min,
    double? max,
  }) {
    return scale(context, designValue, min: min, max: max);
  }

  // ---------------------------------------------------------------------------
  // Breakpoint & Orientation Value Selection
  // ---------------------------------------------------------------------------

  /// Selects a value based on device width breakpoint.
  ///
  /// - Compact (<360) uses [compact].
  /// - Normal (360..599) uses [normal] if provided, else [compact].
  /// - Large (600..839) uses [large] if provided, else nearest smaller value.
  /// - Extra-large (>=840) uses [extraLarge] if provided, else nearest smaller value.
  static T value<T>(
    BuildContext context, {
    required T compact,
    T? normal,
    T? large,
    T? extraLarge,
  }) {
    final w = width(context);
    if (w >= extraLargeBreakpoint && extraLarge != null) {
      return extraLarge;
    }
    if (w >= largeBreakpoint && large != null) {
      return large;
    }
    if (w >= compactBreakpoint && normal != null) {
      return normal;
    }
    return compact;
  }

  /// Selects a value based on screen orientation.
  static T orientationValue<T>(
    BuildContext context, {
    required T portrait,
    required T landscape,
  }) {
    return isLandscape(context) ? landscape : portrait;
  }

  // ---------------------------------------------------------------------------
  // Accessibility & Typography Helpers
  // ---------------------------------------------------------------------------

  /// Retrieves the active [TextScaler] from the ambient [MediaQuery].
  static TextScaler textScaler(BuildContext context) =>
      MediaQuery.textScalerOf(context);

  /// Approximate multiplier of user's active system text scale setting.
  ///
  /// Useful to detect if the user has enabled enlarged accessibility fonts (> 1.25).
  static double effectiveTextScale(BuildContext context) {
    return textScaler(context).scale(14.0) / 14.0;
  }
}

/// A lightweight, constraint-aware layout widget.
///
/// Useful when a sub-component needs to react to its parent widget's width
/// rather than the full viewport screen width.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, BoxConstraints constraints)
  builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}
