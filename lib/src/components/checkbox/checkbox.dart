import 'package:flutter/material.dart';

/// A theme-aware checkbox with an optional label and trailing widget.
///
/// When [label] (or [secondary]) is provided it renders as a tappable
/// [CheckboxListTile]; otherwise it falls back to a bare [Checkbox].
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Widget? secondary;
  final Color? activeColor;
  final Color? checkColor;
  final bool tristate;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.secondary,
    this.activeColor,
    this.checkColor,
    this.tristate = false,
    this.padding,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final effectiveActive = activeColor ?? colors.primary;
    final effectiveCheck = checkColor ?? colors.onPrimary;

    if (label == null && secondary == null) {
      return Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: effectiveActive,
        checkColor: effectiveCheck,
        tristate: tristate,
      );
    }

    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: label != null
          ? Text(
        label!,
        style: labelStyle ??
            Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colors.onSurface),
      )
          : null,
      secondary: secondary,
      activeColor: effectiveActive,
      checkColor: effectiveCheck,
      tristate: tristate,
      contentPadding: padding,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}