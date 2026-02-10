import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
