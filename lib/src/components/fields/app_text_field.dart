import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_package/ui_package.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  final bool obscureText;
  final bool enabled;
  final int maxLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? fillColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: AppTextStyles.body,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: _decoration(),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      filled: true,
      fillColor: fillColor ?? AppColors.inputFill,
      labelText: hintText,
      isDense: true, // ✅ ADD THIS
      labelStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8, // reduced height
      ),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(),
      errorBorder: _errorBorder(),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColors.error),
    );
  }
}
