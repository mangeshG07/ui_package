import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light({Color? primary}) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: primary ?? AppColors.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
