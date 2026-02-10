import 'package:flutter/material.dart';
import 'package:ui_package/src/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool loading;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        child: loading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : Text(text, style: AppTextStyles.button),
      ),
    );
  }
}
