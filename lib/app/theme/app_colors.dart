import 'package:flutter/material.dart';

/// Central color tokens for the Gallery Finance AI application.
/// Derived strictly from the approved design system specification.
abstract final class AppColors {
  // Primary brand palette
  static const Color primaryGreen = Color(0xFF55C481);
  static const Color primaryGreenDark = Color(0xFF3EA367);
  static const Color primaryGreenLight = Color(0xFFE8F7EE);

  // Surfaces and background
  static const Color background = Color(0xFFF7F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF9FAFB);

  // Text hierarchy
  static const Color textPrimary = Color(0xFF101828);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textMuted = Color(0xFF98A2B3);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Borders and dividers
  static const Color border = Color(0xFFE4E7EC);
  static const Color borderFocus = Color(0xFF55C481);

  // Financial semantic indicators
  static const Color outgoing = Color(0xFFE05D52); // Muted coral / warm red
  static const Color outgoingSubtle = Color(0xFFFEECEB);
  static const Color incoming = Color(0xFF0E8472); // Deep teal / blue-green
  static const Color incomingSubtle = Color(0xFFE6F5F2);
  static const Color warning = Color(0xFFE69A19); // Muted amber
  static const Color warningSubtle = Color(0xFFFEF7E6);

  // Neutral grays
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFE4E7EC);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray900 = Color(0xFF101828);
}
