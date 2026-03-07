import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  // Border radius values
  static const double xs = 4.0;
  static const double sm = 6.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double circular = 9999.0;

  // BorderRadius objects
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusXXXL = BorderRadius.all(Radius.circular(xxxl));
  static const BorderRadius radiusCircular = BorderRadius.all(Radius.circular(circular));

  // Top only radius
  static BorderRadius topRadius(double radius) {
    return BorderRadius.vertical(top: Radius.circular(radius));
  }

  static const BorderRadius topLG = BorderRadius.vertical(top: Radius.circular(lg));
  static const BorderRadius topXL = BorderRadius.vertical(top: Radius.circular(xl));
  static const BorderRadius topXXL = BorderRadius.vertical(top: Radius.circular(xxl));

  // Bottom only radius
  static BorderRadius bottomRadius(double radius) {
    return BorderRadius.vertical(bottom: Radius.circular(radius));
  }

  static const BorderRadius bottomLG = BorderRadius.vertical(bottom: Radius.circular(lg));
  static const BorderRadius bottomXL = BorderRadius.vertical(bottom: Radius.circular(xl));

  // Left only radius
  static BorderRadius leftRadius(double radius) {
    return BorderRadius.horizontal(left: Radius.circular(radius));
  }

  // Right only radius
  static BorderRadius rightRadius(double radius) {
    return BorderRadius.horizontal(right: Radius.circular(radius));
  }

  // Custom border radius
  static BorderRadius custom({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0),
      topRight: Radius.circular(topRight ?? 0),
      bottomLeft: Radius.circular(bottomLeft ?? 0),
      bottomRight: Radius.circular(bottomRight ?? 0),
    );
  }
}