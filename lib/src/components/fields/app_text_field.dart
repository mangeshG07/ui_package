import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}
