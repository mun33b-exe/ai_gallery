import 'package:flutter/material.dart';

/// Elevation and soft shadow tokens.
abstract final class AppShadows {
  /// Soft card shadow for elevated floating surfaces.
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A101828), // 4% black
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x05101828), // 2% black
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Subtle shadow for navigation and buttons.
  static const List<BoxShadow> subtle = [
    BoxShadow(color: Color(0x08101828), blurRadius: 6, offset: Offset(0, 2)),
  ];

  /// Bottom navigation bar elevation shadow.
  static const List<BoxShadow> bottomNav = [
    BoxShadow(color: Color(0x08101828), blurRadius: 16, offset: Offset(0, -4)),
  ];
}
