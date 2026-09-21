import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // CX1006 ETERNALS COLOR SYSTEM
  // ============================================================

  static const Color midnight = Color(0xFF0F1E33);
  static const Color cobalt = Color(0xFF2E4A67);
  static const Color antiqueBrass = Color(0xFFB89458);
  static const Color parchment = Color(0xFFD8CEBE);
  static const Color porcelain = Color(0xFFF4F0E8);

  // ============================================================
  // SEMANTIC COLORS
  // ============================================================

  static const Color white = Color(0xFFFFFFFF);

  static const Color errorRed = Color(0xFFB42318);
  static const Color errorSoft = Color(0xFFFDECEC);

  static const Color successGreen = Color(0xFF166534);
  static const Color successSoft = Color(0xFFEAF6EE);

  static const Color warningAmber = Color(0xFF92400E);
  static const Color warningSoft = Color(0xFFFFF7E8);

  static const Color primaryText = midnight;
  static const Color secondaryText = Color(0xFF394B60);
  static const Color mutedText = Color(0xFF667085);

  static const Color border = parchment;

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: cobalt,
      brightness: Brightness.light,
    ).copyWith(
      primary: cobalt,
      onPrimary: white,
      secondary: antiqueBrass,
      onSecondary: midnight,
      error: errorRed,
      onError: white,
      surface: porcelain,
      onSurface: primaryText,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: porcelain,
      canvasColor: porcelain,

      fontFamily: 'Inter',

      // ========================================================
      // TYPOGRAPHY
      // ========================================================

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 52,
          fontWeight: FontWeight.w700,
          height: 1.10,
          letterSpacing: -1.2,
          color: midnight,
        ),
        displayMedium: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          height: 1.12,
          color: midnight,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 1.15,
          color: midnight,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.18,
          color: midnight,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: midnight,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: midnight,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: midnight,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: midnight,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: midnight,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.55,
          color: primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.50,
          color: primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          height: 1.45,
          color: secondaryText,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: midnight,
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: midnight,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: secondaryText,
        ),
      ),

      // ========================================================
      // APP BAR
      // ========================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: midnight,
        foregroundColor: white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: white,
        ),
        iconTheme: IconThemeData(
          color: white,
          size: 24,
        ),
      ),

      // ========================================================
      // CARD
      // ========================================================

      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: parchment,
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // ========================================================
      // ELEVATED BUTTON
      // ========================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cobalt,
          foregroundColor: white,
          minimumSize: const Size(44, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 14,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // FILLED BUTTON
      // ========================================================

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cobalt,
          foregroundColor: white,
          minimumSize: const Size(44, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 14,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // OUTLINED BUTTON
      // ========================================================

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cobalt,
          minimumSize: const Size(44, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 14,
          ),
          side: const BorderSide(
            color: cobalt,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // TEXT BUTTON
      // ========================================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cobalt,
          minimumSize: const Size(44, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // TEXT FIELDS
      // ========================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: parchment,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: parchment,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: cobalt,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: errorRed,
            width: 1.5,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: errorRed,
            width: 2,
          ),
        ),

        labelStyle: const TextStyle(
          color: secondaryText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),

        floatingLabelStyle: const TextStyle(
          color: cobalt,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),

        hintStyle: const TextStyle(
          color: mutedText,
          fontSize: 15,
        ),

        errorStyle: const TextStyle(
          color: errorRed,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),

        prefixIconColor: cobalt,
        suffixIconColor: cobalt,
      ),

      // ========================================================
      // DIVIDER
      // ========================================================

      dividerTheme: const DividerThemeData(
        color: parchment,
        thickness: 1,
      ),

      // ========================================================
      // ICON
      // ========================================================

      iconTheme: const IconThemeData(
        color: cobalt,
        size: 24,
      ),

      // ========================================================
      // PROGRESS
      // ========================================================

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: cobalt,
        linearTrackColor: parchment,
        circularTrackColor: parchment,
      ),

      // ========================================================
      // SNACKBAR
      // ========================================================

      snackBarTheme: SnackBarThemeData(
        backgroundColor: midnight,
        contentTextStyle: const TextStyle(
          color: white,
          fontSize: 14,
        ),
        actionTextColor: antiqueBrass,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ========================================================
      // DIALOG
      // ========================================================

      dialogTheme: DialogThemeData(
        backgroundColor: white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(
            color: parchment,
          ),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: midnight,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 15,
          height: 1.5,
          color: primaryText,
        ),
      ),

      // ========================================================
      // TOOLTIP
      // ========================================================

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: midnight,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: white,
          fontSize: 13,
        ),
      ),

      focusColor: cobalt.withValues(alpha: 0.12),
      splashColor: cobalt.withValues(alpha: 0.12),
      highlightColor: cobalt.withValues(alpha: 0.08),
    );
  }
}