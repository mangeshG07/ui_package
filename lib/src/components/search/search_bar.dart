import 'package:flutter/material.dart';

/// A theme-aware search field with a magnifier icon and a clear button.
class CustomSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? fillColor;
  final double? borderRadius;
  final double? height;
  final bool autofocus;
  final bool showClearButton;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.borderRadius = 28,
    this.height = 46,
    this.autofocus = false,
    this.showClearButton = true,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _hasText = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: widget.fillColor ?? colors.surfaceContainerHighest.withValues(alpha: 0.6),
        prefixIcon: Icon(Icons.search, color: colors.onSurfaceVariant),
        suffixIcon: widget.showClearButton && _hasText
            ? IconButton(
          icon: const Icon(Icons.clear),
          color: colors.onSurfaceVariant,
          onPressed: () {
            _controller.clear();
            widget.onChanged?.call('');
          },
        )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: (widget.height ?? 46) * 0.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}