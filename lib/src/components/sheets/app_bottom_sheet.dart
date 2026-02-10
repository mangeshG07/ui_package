import 'package:flutter/material.dart';

class AppBottomSheet {
  static void show(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: child,
      ),
    );
  }
}
