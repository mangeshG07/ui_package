import 'dart:async';
import 'package:flutter/material.dart';

class AppCarouselController {
  final CarouselController controller;

  Timer? _autoPlayTimer;
  int _currentIndex = 0;

  AppCarouselController({int initialIndex = 0})
      : controller = CarouselController(initialItem: initialIndex) {
    _currentIndex = initialIndex;
  }

  void dispose() {
    _autoPlayTimer?.cancel();
    controller.dispose();
  }

  void animateTo(int index) {
    _currentIndex = index;
    controller.animateToItem(index);
  }

  void jumpTo(int index) {
    _currentIndex = index;
    controller.jumpTo(double.parse(index.toString()));
  }

  // 🔥 AutoPlay
  void startAutoPlay({
    required int itemCount,
    Duration duration = const Duration(seconds: 3),
    bool loop = true,
  }) {
    stopAutoPlay();

    _autoPlayTimer = Timer.periodic(duration, (_) {
      if (_currentIndex < itemCount - 1) {
        _currentIndex++;
      } else {
        if (loop) {
          _currentIndex = 0;
        } else {
          stopAutoPlay();
          return;
        }
      }

      controller.animateToItem(_currentIndex);
    });
  }

  void stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void updateIndex(int index) {
    _currentIndex = index;
  }
}
