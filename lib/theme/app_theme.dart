import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color navy = midnight;
  static const Color primaryBlue = cobalt;
  static const Color lightBlue = Color(0xFFE7EEF5);
  static const Color background = porcelain;
  static const Color error = errorRed;
  static const Color success = successGreen;

  // ============================================================
  // CX1006 ETERNALS — GLOBAL COLOR SYSTEM
  // ============================================================

  /// Deep navy used for primary text, headings, AppBar and
  /// important high-contrast surfaces.
  static const Color midnight = Color(0xFF0F1E33);

  /// Muted deep blue used for primary actions and interactive
  /// elements.
  static const Color cobalt = Color(0xFF2E4A67);

  /// Civic teal accent used for accessibility highlights,
  /// ISL elements and important visual accents.
  static const Color antiqueBrass = Color(0xFF0F766E);

  /// Cool neutral used for borders, dividers and subtle outlines.
  static const Color parchment = Color(0xFFCBD5E1);

  /// Main cool page background.
  static const Color porcelain = Color(0xFFF3F6F8);

  // ============================================================
  // SEMANTIC COLORS
  // ============================================================

  /// Error color.
  ///
  /// Kept separate from the five-color visual identity because
  /// errors must remain immediately recognizable and accessible.
  static const Color errorRed = Color(0xFFB42318);

  /// Success color.
  static const Color successGreen = Color(0xFF166534);

  /// Warning color.
  static const Color warningAmber = Color(0xFF92400E);

  /// White used when required for high-contrast content on dark
  /// surfaces.
  static const Color white = Color(0xFFFFFFFF);

  /// Soft dark surface variation.
  static const Color midnightSurface = Color(0xFF172942);

  /// Very subtle surface variation against Porcelain.
  static const Color porcelainSurface = Color(0xFFFFFFFF);

  // ============================================================
  // TEXT COLORS
  // ============================================================

  static const Color primaryText = midnight;

  static const Color secondaryText = Color(0xFF394B60);

  static const Color disabledText = Color(0xFF667085);

  static const Color inverseText = white;

  // ============================================================
  // BORDER COLORS
  // ============================================================

  static const Color border = parchment;

  static const Color focusedBorder = cobalt;

  static const Color errorBorder = errorRed;

  static const Color successBorder = successGreen;

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: cobalt,
      brightness: Brightness.light,
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

      // ----------------------------------------------------------
      // COLOR SCHEME
      // ----------------------------------------------------------

      colorScheme: colorScheme,

      scaffoldBackgroundColor: porcelain,

      canvasColor: porcelain,

      // ----------------------------------------------------------
      // TYPOGRAPHY
      // ----------------------------------------------------------

      fontFamily: 'Inter',

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
          letterSpacing: -0.8,
          color: midnight,
        ),

        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 1.15,
          letterSpacing: -0.6,
          color: midnight,
        ),

        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.18,
          letterSpacing: -0.4,
          color: midnight,
        ),

        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.20,
          color: midnight,
        ),

        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.25,
          color: midnight,
        ),

        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.30,
          color: midnight,
        ),

        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.35,
          color: midnight,
        ),

        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.35,
          color: midnight,
        ),

        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: 1.55,
          color: primaryText,
        ),

        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.50,
          color: primaryText,
        ),

        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 1.45,
          color: secondaryText,
        ),

        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          height: 1.25,
          color: midnight,
        ),

        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1.25,
          color: midnight,
        ),

        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.25,
          color: secondaryText,
        ),
      ),

      // ----------------------------------------------------------
      // APP BAR
      // ----------------------------------------------------------

      appBarTheme: const AppBarTheme(
        backgroundColor: midnight,
        foregroundColor: white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
          color: white,
        ),

        iconTheme: IconThemeData(
          color: white,
          size: 24,
        ),

        actionsIconTheme: IconThemeData(
          color: white,
          size: 24,
        ),
      ),

      // ----------------------------------------------------------
      // CARD
      // ----------------------------------------------------------

      cardTheme: CardThemeData(
        color: porcelainSurface,
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

      // ----------------------------------------------------------
      // ELEVATED BUTTON
      // ----------------------------------------------------------

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cobalt,
          foregroundColor: white,

          minimumSize: const Size(
            44,
            52,
          ),

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
            height: 1.25,
          ),

          iconColor: white,

          disabledBackgroundColor: parchment,
          disabledForegroundColor: disabledText,
        ),
      ),

      // ----------------------------------------------------------
      // FILLED BUTTON
      // ----------------------------------------------------------

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cobalt,
          foregroundColor: white,

          minimumSize: const Size(
            44,
            52,
          ),

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
            height: 1.25,
          ),

          iconColor: white,

          disabledBackgroundColor: parchment,
          disabledForegroundColor: disabledText,
        ),
      ),

      // ----------------------------------------------------------
      // OUTLINED BUTTON
      // ----------------------------------------------------------

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cobalt,

          minimumSize: const Size(
            44,
            52,
          ),

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
            height: 1.25,
          ),

          iconColor: cobalt,
        ),
      ),

      // ----------------------------------------------------------
      // TEXT BUTTON
      // ----------------------------------------------------------

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cobalt,

          minimumSize: const Size(
            44,
            44,
          ),

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

          iconColor: cobalt,
        ),
      ),

      // ----------------------------------------------------------
      // INPUT DECORATION
      // ----------------------------------------------------------

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
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: parchment,
            width: 1,
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

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: parchment,
            width: 1,
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
          color: disabledText,
          fontSize: 15,
        ),

        errorStyle: const TextStyle(
          color: errorRed,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),

        prefixIconColor: cobalt,
        suffixIconColor: cobalt,

        iconColor: cobalt,
      ),

      // ----------------------------------------------------------
      // DROPDOWN
      // ----------------------------------------------------------

      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(
          fontSize: 15,
          color: primaryText,
        ),

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
        ),

        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            porcelainSurface,
          ),

          elevation: const WidgetStatePropertyAll(4),

          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: parchment,
              ),
            ),
          ),
        ),
      ),

      // ----------------------------------------------------------
      // DIVIDER
      // ----------------------------------------------------------

      dividerTheme: const DividerThemeData(
        color: parchment,
        thickness: 1,
        space: 1,
      ),

      // ----------------------------------------------------------
      // ICON THEME
      // ----------------------------------------------------------

      iconTheme: const IconThemeData(
        color: cobalt,
        size: 24,
      ),

      // ----------------------------------------------------------
      // CHECKBOX
      // ----------------------------------------------------------

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return cobalt;
            }

            return white;
          },
        ),

        checkColor: const WidgetStatePropertyAll(
          white,
        ),

        side: const BorderSide(
          color: cobalt,
          width: 1.5,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // ----------------------------------------------------------
      // RADIO
      // ----------------------------------------------------------

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return cobalt;
            }

            return secondaryText;
          },
        ),
      ),

      // ----------------------------------------------------------
      // SWITCH
      // ----------------------------------------------------------

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return white;
            }

            return secondaryText;
          },
        ),

        trackColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return cobalt;
            }

            return parchment;
          },
        ),

        trackOutlineColor: const WidgetStatePropertyAll(
          parchment,
        ),
      ),

      // ----------------------------------------------------------
      // PROGRESS INDICATOR
      // ----------------------------------------------------------

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: cobalt,
        linearTrackColor: parchment,
        circularTrackColor: parchment,
      ),

      // ----------------------------------------------------------
      // SNACKBAR
      // ----------------------------------------------------------

      snackBarTheme: SnackBarThemeData(
        backgroundColor: midnight,
        contentTextStyle: const TextStyle(
          color: white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        actionTextColor: antiqueBrass,

        behavior: SnackBarBehavior.floating,

        elevation: 4,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ----------------------------------------------------------
      // DIALOG
      // ----------------------------------------------------------

      dialogTheme: DialogThemeData(
        backgroundColor: porcelainSurface,
        elevation: 8,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(
            color: parchment,
            width: 1,
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

      // ----------------------------------------------------------
      // TOOLTIP
      // ----------------------------------------------------------

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: midnight,
          borderRadius: BorderRadius.circular(8),
        ),

        textStyle: const TextStyle(
          color: white,
          fontSize: 13,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),

      // ----------------------------------------------------------
      // FOCUS
      // ----------------------------------------------------------

      focusColor: cobalt.withValues(alpha: 0.12),

      // ----------------------------------------------------------
      // VISUAL DENSITY
      // ----------------------------------------------------------

      visualDensity: VisualDensity.standard,

      // ----------------------------------------------------------
      // MATERIAL SPLASH / HIGHLIGHT
      // ----------------------------------------------------------

      splashFactory: InkRipple.splashFactory,

      splashColor: cobalt.withValues(alpha: 0.12),

      highlightColor: cobalt.withValues(alpha: 0.08),
    );
  }
}