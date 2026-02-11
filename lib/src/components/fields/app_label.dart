import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

/// A reusable professional form label widget.
///
/// Features:
/// - Required indicator (*)
/// - Custom style override
/// - Custom required color
/// - Custom bottom spacing
/// - Optional suffix widget
/// - Theme friendly
class AppLabel extends StatelessWidget {
  /// Main label text
  final String text;

  /// Whether to show required asterisk
  final bool isRequired;

  /// Custom text style (optional)
  final TextStyle? style;

  /// Custom required color (optional)
  final Color? requiredColor;

  /// Bottom spacing
  final double bottomSpacing;

  /// Optional widget at end (ex: info icon)
  final Widget? suffix;

  const AppLabel({
    super.key,
    required this.text,
    this.isRequired = false,
    this.style,
    this.requiredColor,
    this.bottomSpacing = 6,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? AppTextStyles.label;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: text,
                style: defaultStyle,
                children: isRequired
                    ? [
                        TextSpan(
                          text: ' *',
                          style: defaultStyle.copyWith(
                            color: requiredColor ?? AppColors.error,
                          ),
                        ),
                      ]
                    : [],
              ),
            ),
          ),

          if (suffix != null) ...[const SizedBox(width: 6), suffix!],
        ],
      ),
    );
  }
}
