import 'package:flutter/material.dart';

/// 8-point spacing grid tokens and screen margins.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 48;

  // Screen horizontal margins (16-24px)
  static const double screenMargin = 20;
  static const double screenMarginSm = 16;
  static const double screenMarginLg = 24;

  // Pre-built EdgeInsets for consistent padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenMargin,
    vertical: lg,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingLg = EdgeInsets.all(xl);
  static const EdgeInsets cardPaddingSm = EdgeInsets.all(md);
}
