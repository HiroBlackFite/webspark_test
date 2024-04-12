import 'package:flutter/material.dart';

final _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
);
final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  contentPadding: const EdgeInsets.only(bottom: 12, left: 10, right: 10),
  errorBorder: _outlineInputBorder,
  focusedErrorBorder: _outlineInputBorder,
  disabledBorder: _outlineInputBorder,
  enabledBorder: _outlineInputBorder,
  focusedBorder: _outlineInputBorder,
);

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6750A4),
      primaryContainer: Color(0xFFEADDFF),
      onPrimaryContainer: Color(0xFF21005D),
      secondary: Color(0xFF625B71),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE8DEF8),
      onSecondaryContainer: Color(0xFF1D192B),
      tertiary: Color(0xFF7D5260),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD8E4),
      onTertiaryContainer: Color(0xFF31111D),
      error: Color(0xFFB3261E),
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      background: Color(0xFFFFFBFE),
      onBackground: Color(0xFF1C1B1F),
      surface: Color(0xFFFFFBFE),
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFF313033),
      onInverseSurface: Color(0xFFF4EFF4),
      inversePrimary: Color(0xFFD0BCFF),
      surfaceTint: Color(0xFF6750A4),
    ),
  ).copyWith(
    inputDecorationTheme: _inputDecorationTheme,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFD0BCFF),
      onPrimary: Color(0xFF3700B3),
      primaryContainer: Color(0xFF4F378B),
      onPrimaryContainer: Color(0xFFEADDFF),
      secondary: Color(0xFFCCC2DC),
      onSecondary: Color(0xFF332D41),
      secondaryContainer: Color(0xFF4A4458),
      onSecondaryContainer: Color(0xFFE8DEF8),
      tertiary: Color(0xFFEFB8C8),
      onTertiary: Color(0xFF492532),
      tertiaryContainer: Color(0xFF633B48),
      onTertiaryContainer: Color(0xFFFFD8E4),
      error: Color(0xFFF2B8B5),
      errorContainer: Color(0xFF8C1D18),
      onError: Color(0xFF601410),
      onErrorContainer: Color(0xFFF9DEDC),
      background: Color(0xFF1C1B1F),
      onBackground: Color(0xFFE6E1E5),
      surface: Color(0xFF1C1B1F),
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFFE6E1E5),
      onInverseSurface: Color(0xFF313033),
      inversePrimary: Color(0xFF6750A4),
    ),
  ).copyWith(
    inputDecorationTheme: _inputDecorationTheme,
  );
}
