import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_package/ui_package.dart';

class AppPermissions {
  /// Public API – request permission safely
  static Future<bool> request(AppPermission permission) async {
    final perm = _mapPermission(permission);

    final status = await perm.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await perm.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      _showSettingsDialog();
      return false;
    }

    return false;
  }

  /// Check only (no popup)
  static Future<bool> isGranted(AppPermission permission) async {
    return await _mapPermission(permission).isGranted;
  }

  /// Map app permission → platform permission
  static Permission _mapPermission(AppPermission permission) {
    switch (permission) {
      case AppPermission.camera:
        return Permission.camera;

      case AppPermission.storage:
        return Permission.storage;

      case AppPermission.photos:
        return Permission.photos;

      case AppPermission.location:
        return Permission.location;

      case AppPermission.notification:
        return Permission.notification;
    }
  }

  /// Dialog when permanently denied
  static void _showSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Permission is permanently denied. Please enable it from app settings.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
              Get.back();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}

// final allowed = await AppPermissions.request(AppPermission.camera);
// if (allowed) {
// // open camera
// }
//
//
// if (await AppPermissions.request(AppPermission.photos)) {
// // pick image
// }
//
//
// if (await AppPermissions.request(AppPermission.storage)) {
// // read/write file
// }
//
//
// if (await AppPermissions.request(AppPermission.location)) {
// // fetch location
// }
//
//
// await AppPermissions.request(AppPermission.notification);
