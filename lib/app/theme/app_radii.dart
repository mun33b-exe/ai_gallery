import 'package:flutter/material.dart';

/// Corner radius tokens. Cards use 12-20 px radii.
abstract final class AppRadii {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;

  // BorderRadius helpers
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusPill = BorderRadius.all(
    Radius.circular(pill),
  );

  // Specific component radii
  static const BorderRadius cardRadius = radiusLg; // 16px
  static const BorderRadius buttonRadius = radiusMd; // 12px
  static const BorderRadius inputRadius = radiusMd; // 12px
  static const BorderRadius bottomSheetRadius = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}
