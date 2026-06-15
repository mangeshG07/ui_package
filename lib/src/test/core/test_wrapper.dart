import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';

class TestWrapper {
  static Widget wrap(Widget child, BuildContext context) {
    return ScreenUtilConfig.init(
      context: context,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: child),
      ),
      minTextAdapt: true,
    );
  }
}
