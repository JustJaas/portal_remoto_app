import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/theme/app_palette.dart';

class AppTheme {
  static ThemeData build() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppPalette.seed,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLow,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      searchBarTheme: const SearchBarThemeData(
        elevation: WidgetStatePropertyAll<double>(1),
      ),
    );
  }
}
