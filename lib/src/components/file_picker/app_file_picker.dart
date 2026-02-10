import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';
import 'picker_sheet.dart';

class AppFilePicker {
  AppFilePicker._(); // ❌ no instance

  static Future<void> open({
    required Function(File file) onPicked,
    Function(List<File> files)? onMultiPicked,
    AppFilePickerConfig config = const AppFilePickerConfig(),
  }) async {
    Get.bottomSheet(
      SafeArea(
        child: PickerSheet(
          config: config,
          onPicked: onPicked,
          onMultiPicked: onMultiPicked,
        ),
      ),
      isDismissible: true,
    );
  }
}



// AppFilePicker.open(
// config: const AppFilePickerConfig(
// allowVideo: true,
// allowMultiImage: true,
// ),
// onPicked: (file) {
// print(file.path);
// },
// onMultiPicked: (files) {
// print(files.length);
// },
// );
