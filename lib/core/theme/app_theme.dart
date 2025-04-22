import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.title,
        background: AppColors.gray100,
        surface: AppColors.white,
        error: AppColors.danger,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
    );
  }
}
