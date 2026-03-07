import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';

class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<Widget>? actions,
    bool showCloseButton = true,
    bool useRootNavigator = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppRadius.topXL,
      ),
      backgroundColor: backgroundColor ?? AppColors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          constraints: BoxConstraints(
            maxHeight: height?.h ?? MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(),
              if (title != null || showCloseButton) ...[
                _buildHeader(title: title, actions: actions, showCloseButton: showCloseButton),
                AppSpacing.verticalSM,
              ],
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: AppSpacing.sm),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  static Widget _buildHeader({
    String? title,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.h5,
              ),
            ),
          if (actions != null) ...actions,
          if (showCloseButton)
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20.sp,
                color: AppColors.grey600,
              ),
              onPressed: () => Get.back(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  static Future<T?> showOptions<T>({
    required BuildContext context,
    required String title,
    required List<BottomSheetOption<T>> options,
    bool isDismissible = true,
  }) {
    return show<T>(
      context: context,
      title: title,
      isDismissible: isDismissible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          return ListTile(
            leading: option.leading != null ? Icon(option.leading, color: option.color) : null,
            title: Text(
              option.title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: option.color,
              ),
            ),
            onTap: () {
              Navigator.pop(context, option.value);
              option.onTap?.call();
            },
          );
        }).toList(),
      ),
    );
  }

  static Future<T?> showMenu<T>({
    required BuildContext context,
    required String title,
    required List<PopupMenuItem<T>> items,
  }) {
    return show<T>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  static Future<T?> showConfirmation<T>({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    T? confirmValue,
    VoidCallback? onConfirm,
    bool isDestructive = false,
  }) {
    return show<T>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalLG,
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: cancelText,
                  onTap: () => Navigator.pop(context),
                  type: AppButtonType.outline,
                ),
              ),
              AppSpacing.horizontalSM,
              Expanded(
                child: AppButton(
                  text: confirmText,
                  onTap: () {
                    onConfirm?.call();
                    Navigator.pop(context, confirmValue);
                  },
                  type: isDestructive ? AppButtonType.text : AppButtonType.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetOption<T> {
  final String title;
  final IconData? leading;
  final Color? color;
  final T? value;
  final VoidCallback? onTap;

  BottomSheetOption({
    required this.title,
    this.leading,
    this.color,
    this.value,
    this.onTap,
  });
}