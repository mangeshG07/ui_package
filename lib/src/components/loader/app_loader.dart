import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;
  final String? message;

  const AppLoader({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 3.0,
    this.message,
  });

  factory AppLoader.circular({
    double? size,
    Color? color,
    double strokeWidth = 3.0,
    String? message,
  }) {
    return AppLoader(
      size: size,
      color: color,
      strokeWidth: strokeWidth,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size?.w ?? 40.w,
            height: size?.h ?? 40.h,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: TextStyle(fontSize: 14.sp, color: AppColors.grey600),
            ),
          ],
        ],
      ),
    );
  }
}

class AppLoaderOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final Color? backgroundColor;

  const AppLoaderOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withValues(alpha: 0.3),
            child: Center(child: AppLoader.circular(message: message)),
          ),
      ],
    );
  }
}

class AppLoaderPage extends StatelessWidget {
  final String? message;

  const AppLoaderPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppLoader.circular(message: message));
  }
}
