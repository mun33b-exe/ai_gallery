import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Application theme configurations adhering strictly to the design system.
abstract final class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primaryGreen,
      onPrimary: AppColors.textWhite,
      primaryContainer: AppColors.primaryGreenLight,
      onPrimaryContainer: AppColors.primaryGreenDark,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.outgoing,
      onError: AppColors.textWhite,
      outline: AppColors.border,
      outlineVariant: AppColors.gray200,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.titleLarge,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.cardRadius,
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.buttonRadius,
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.textWhite,
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 50),
          side: const BorderSide(color: AppColors.border, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.buttonRadius,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreenDark,
          textStyle: AppTypography.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),
        labelStyle: AppTypography.bodyMedium,
        border: const OutlineInputBorder(
          borderRadius: AppRadii.inputRadius,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadii.inputRadius,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadii.inputRadius,
          borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadii.inputRadius,
          borderSide: BorderSide(color: AppColors.outgoing),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadii.inputRadius,
          borderSide: BorderSide(color: AppColors.outgoing, width: 1.5),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // Navigation bar theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        elevation: 0,
        indicatorColor: AppColors.primaryGreenLight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelSmall.copyWith(
              color: AppColors.primaryGreenDark,
              fontWeight: FontWeight.w600,
            );
          }
          return AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: AppColors.primaryGreenDark,
              size: 24,
            );
          }
          return const IconThemeData(color: AppColors.textSecondary, size: 24);
        }),
      ),
    );
  }
}
