import 'package:flutter/material.dart';

class ProSearchTheme {
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const ProSearchTheme({
    this.borderRadius = 16,
    this.elevation = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundColor,
  });
}
