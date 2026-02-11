import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class EmptyState extends StatelessWidget {
  final String title;

  const EmptyState({
    super.key,
    this.title = "No data found",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: AppTextStyles.body),
    );
  }
}
