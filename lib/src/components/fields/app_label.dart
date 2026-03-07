import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isRequired;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets? padding;
  final bool showRequiredAsterisk;

  const AppLabel({
    super.key,
    required this.text,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isRequired = false,
    this.prefix,
    this.suffix,
    this.padding,
    this.showRequiredAsterisk = true,
  });

  factory AppLabel.required({
    required String text,
    TextStyle? style,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return AppLabel(
      text: text,
      style: style,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      isRequired: true,
    );
  }

  factory AppLabel.small(String text) {
    return AppLabel(
      text: text,
      style: AppTextStyles.labelSmall,
    );
  }

  factory AppLabel.medium(String text) {
    return AppLabel(
      text: text,
      style: AppTextStyles.labelMedium,
    );
  }

  factory AppLabel.large(String text) {
    return AppLabel(
      text: text,
      style: AppTextStyles.labelLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: _getStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (prefix == null && suffix == null && !isRequired) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: textWidget,
      );
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefix != null) ...[
            prefix!,
            AppSpacing.horizontalXS,
          ],
          textWidget,
          if (isRequired && showRequiredAsterisk) ...[
            AppSpacing.horizontalXXS,
            Text(
              '*',
              style: _getStyle().copyWith(
                color: AppColors.error,
              ),
            ),
          ],
          if (suffix != null) ...[
            AppSpacing.horizontalXS,
            suffix!,
          ],
        ],
      ),
    );
  }

  TextStyle _getStyle() {
    return (style ?? AppTextStyles.labelMedium).copyWith(
      color: color ?? (style?.color ?? AppColors.grey700),
      fontSize: fontSize ?? style?.fontSize,
      fontWeight: fontWeight ?? style?.fontWeight,
    );
  }
}