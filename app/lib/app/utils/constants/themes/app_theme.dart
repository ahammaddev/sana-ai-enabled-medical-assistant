import 'package:flutter/material.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';
import 'package:sana/app/utils/constants/themes/font_themes.dart';

class AppTheme {
  AppTheme._();

  static final themedata = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.neutral,
    textTheme: FontThemes.textTheme,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.neutral,

      error: AppColors.tertiary,

      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: Color(0xFF1A202C),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
