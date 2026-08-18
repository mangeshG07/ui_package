import 'package:flutter/material.dart';

/// A reusable alert dialog that can be customized with a title, content, and
/// actions, and automatically matches the app theme.
class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool barrierDismissible;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.barrierDismissible = true,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[Text(title!, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12)],
            if (content != null) ...[content!, const SizedBox(height: 16)],
            if (actions != null && actions!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }

  /// Shows the dialog and returns the future of any value popped by the actions.
  static Future<T?> show<T>(
      BuildContext context, {
        String? title,
        Widget? content,
        List<Widget>? actions,
        bool barrierDismissible = true,
      }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CustomAlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}