import 'package:flutter/material.dart';

/// A theme-aware badge that overlays a [child] with a count or dot.
class CustomBadge extends StatelessWidget {
  final Widget child;
  final int? count;
  final bool showDot;
  final Color? color;
  final Color? textColor;
  final int maxCount;
  final double? offsetX;
  final double? offsetY;
  final EdgeInsets padding;
  final bool isLabelVisible;

  const CustomBadge({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.color,
    this.textColor,
    this.maxCount = 99,
    this.offsetX,
    this.offsetY,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    this.isLabelVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colors.error;

    if (!isLabelVisible) return child;

    final Widget label;
    if (showDot) {
      label = Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: effectiveColor, shape: BoxShape.circle),
      );
    } else if (count != null) {
      final text = count! > maxCount ? '$maxCount+' : '$count';
      label = Container(
        padding: padding,
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: textColor ?? colors.onError),
        ),
      );
    } else {
      label = const SizedBox.shrink();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: offsetY ?? -8,
          right: offsetX ?? -8,
          child: label,
        ),
      ],
    );
  }
}