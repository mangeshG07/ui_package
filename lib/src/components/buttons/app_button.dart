import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool loading;
  final bool enabled;

  final AppButtonType type;
  final AppButtonSize size;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  final double? borderRadius;
  final TextStyle? textStyle;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.loading = false,
    this.enabled = true,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final height = _heightBySize();
    final radius = borderRadius ?? 12;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: _buttonStyle(radius),
        onPressed: (enabled && !loading) ? onTap : null,
        child: loading
            ? _loader()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Text(text, style: textStyle ?? _textStyle()),
                ],
              ),
      ),
    );
  }

  // ---------------- helpers ----------------

  double _heightBySize() {
    switch (size) {
      case AppButtonSize.small:
        return 40;
      case AppButtonSize.large:
        return 56;
      default:
        return 48;
    }
  }

  ButtonStyle _buttonStyle(double radius) {
    switch (type) {
      case AppButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? Colors.blue,
          elevation: 0,
          side: BorderSide(color: borderColor ?? Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        );

      case AppButtonType.text:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? Colors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        );

      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.grey.shade200,
          foregroundColor: textColor ?? Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        );

      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.blue,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        );
    }
  }

  TextStyle _textStyle() {
    return AppTextStyles.button.copyWith(
      color:
          textColor ??
          (type == AppButtonType.primary ? Colors.white : Colors.blue),
    );
  }

  Widget _loader() {
    return const AppLoader();
  }
}
