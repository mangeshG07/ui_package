import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ui_package/src/components/extensions/widget_extensions.dart';
import 'package:ui_package/ui_package.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = const Color(0xFF10B981);
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        backgroundColor = const Color(0xFFEF4444);
        icon = Icons.error_rounded;
        break;
      case SnackbarType.warning:
        backgroundColor = const Color(0xFFF59E0B);
        icon = Icons.warning_rounded;
        break;
      case SnackbarType.info:
        backgroundColor = const Color(0xFF0066FF);
        icon = Icons.info_rounded;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColors.white, size: 18.w),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
              ),
            ).expanded(),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.all(16.w),
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: AppColors.white,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}
