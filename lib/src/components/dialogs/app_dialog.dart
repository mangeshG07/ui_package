import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static Future<bool?> confirm({
    required String title,
    required String message,
  }) {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
