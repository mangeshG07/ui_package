import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../buttons/app_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final String? imagePath;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double? imageHeight;
  final double? imageWidth;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.imagePath,
    this.icon,
    this.buttonText,
    this.onButtonPressed,
    this.imageHeight,
    this.imageWidth,
  });

  factory EmptyState.withIcon({
    required String title,
    String? message,
    IconData? icon = Icons.inbox,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return EmptyState(
      title: title,
      message: message,
      icon: icon,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  factory EmptyState.withImage({
    required String title,
    String? message,
    required String imagePath,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return EmptyState(
      title: title,
      message: message,
      imagePath: imagePath,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            AppSpacing.verticalLG,
            Text(
              title,
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.verticalSM,
              Text(
                message!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              AppSpacing.verticalXL,
              AppButton(
                text: buttonText!,
                onTap: onButtonPressed,
                // type: AppButtonType.primary,
                // size: AppButtonSize.medium,
                // isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        height: imageHeight?.h ?? 120.h,
        width: imageWidth?.w ?? 120.w,
        fit: BoxFit.contain,
      );
    }

    if (icon != null) {
      return Icon(
        icon,
        size: 80.sp,
        color: AppColors.grey400,
      );
    }

    return Icon(
      Icons.inbox,
      size: 80.sp,
      color: AppColors.grey400,
    );
  }
}