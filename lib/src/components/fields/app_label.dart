import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';


class AppLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const AppLabel(
      this.text, {
        super.key,
        this.isRequired = false,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: text,
            style: AppTextStyles.label,
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.error),
              ),
            ]
                : [],
          ),
        ),
      ),
    );
  }
}
