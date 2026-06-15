import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestWrapper {
  static Widget wrap(Widget child) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: child),
    );
  }
}