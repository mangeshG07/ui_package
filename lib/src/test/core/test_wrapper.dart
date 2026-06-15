import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';

class TestWrapper {
  static Widget wrap(Widget child) {
    return ScreenUtilConfig.init(
      context: Get.context!,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: child),
      ),
      minTextAdapt: true,
    );
  }
}
