import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final int? minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool autocorrect;
  final bool showCursor;
  final String? errorText;
  final bool hasError;
  final Color? fillColor;
  final bool filled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final EdgeInsets? contentPadding;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final bool isRequired;
  final String? helperText;
  final Widget? helper;
  final Widget? labelWidget;
  final bool showLabel;
  final bool showCharacterCount;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.minLines,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.focusNode,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.autocorrect = true,
    this.showCursor = true,
    this.errorText,
    this.hasError = false,
    this.fillColor,
    this.filled = true,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.contentPadding,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.isRequired = false,
    this.helperText,
    this.helper,
    this.labelWidget,
    this.showLabel = true,
    this.showCharacterCount = false,
    this.inputFormatters,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel) _buildLabel(),
        if (widget.showLabel) AppSpacing.verticalXS,
        _buildTextField(),
        if (widget.helperText != null || widget.helper != null)
          _buildHelperText(),
        if (widget.errorText != null || widget.hasError) _buildErrorText(),
      ],
    );
  }

  Widget _buildLabel() {
    if (widget.labelWidget != null) return widget.labelWidget!;

    return Row(
      children: [
        Text(
          widget.label,
          style: widget.labelStyle ?? AppTextStyles.labelLarge,
        ),
        if (widget.isRequired)
          Text(
            ' *',
            style: AppTextStyles.labelLarge.copyWith(color: AppColors.error),
          ),
      ],
    );
  }

  Widget _buildTextField() {
    final effectiveSuffixIcon = _getSuffixIcon();

    return TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ? _obscureText : false,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.showCharacterCount ? widget.maxLength : null,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      showCursor: widget.showCursor,
      style: widget.textStyle ?? AppTextStyles.bodyMedium,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: effectiveSuffixIcon,
        hintText: widget.hint,
        hintStyle:
            widget.hintStyle ??
            AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400),
        filled: widget.filled,
        fillColor: _getFillColor(),
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
        border:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              borderSide: BorderSide.none,
            ),
        enabledBorder:
            widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              borderSide: BorderSide.none,
            ),
        focusedBorder:
            widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
        errorBorder:
            widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              borderSide: const BorderSide(color: AppColors.error),
            ),
        focusedErrorBorder:
            widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md.r),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
        counterText: widget.showCharacterCount ? null : '',
      ),
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: 20.sp,
          color: AppColors.grey500,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: widget.suffixIcon,
        ),
      );
    }

    return null;
  }

  Color _getFillColor() {
    if (!widget.enabled) {
      return AppColors.grey100;
    }
    if (widget.hasError || widget.errorText != null) {
      return AppColors.error.withValues(alpha: 0.05);
    }
    return widget.fillColor ?? AppColors.grey50;
  }

  Widget _buildHelperText() {
    if (widget.helper != null) return widget.helper!;

    return Padding(
      padding: EdgeInsets.only(left: AppSpacing.sm, top: AppSpacing.xs),
      child: Text(widget.helperText!, style: AppTextStyles.caption),
    );
  }

  Widget _buildErrorText() {
    return Padding(
      padding: EdgeInsets.only(left: AppSpacing.sm, top: AppSpacing.xs),
      child: Text(
        widget.errorText ?? 'Invalid input',
        style: AppTextStyles.caption.copyWith(color: AppColors.error),
      ),
    );
  }
}
