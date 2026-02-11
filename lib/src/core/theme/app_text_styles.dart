import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppTextStyles {
  AppTextStyles._();
  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(fontSize: 14, color: AppColors.textSecondary);

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );


  static TextStyle hint = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static TextStyle label = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
}
