import 'dart:math' as math;

extension NumExtensions on num {
  /// Formats the number with commas as thousand separators.
  String formatWithCommas() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
    );
  }

  /// Rounds the number to a specified number of decimal places.
  num roundTo(int decimalPlaces) {
    final mod = math.pow(10, decimalPlaces);
    return (this * mod).round() / mod;
  }

  /// Clamps the number between [min] and [max] values.
  num clamp(num min, num max) {
    return this < min ? min : (this > max ? max : this);
  }

  /// Returns the number as a percentage string (e.g., 0.5 -> "50%").
  String toPercentage([int decimalPlaces = 1]) {
    return '${(this * 100).roundTo(decimalPlaces)}%';
  }

  /// Checks if the number is between [min] and [max] (inclusive).
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }

  /// Returns absolute value.
  num abs() {
    return this < 0 ? -this : this;
  }

  /// Returns the sign of the number (-1, 0, or 1).
  int signum() {
    if (this > 0) return 1;
    if (this < 0) return -1;
    return 0;
  }

  /// Formats a duration in milliseconds to a human readable string.
  String formatDuration() {
    if (this < 1000) return '${this}ms';
    if (this < 60000) return '${(this / 1000).roundTo(1)}s';
    if (this < 3600000) return '${(this / 60000).roundTo(1)}m';
    return '${(this / 3600000).roundTo(1)}h';
  }

  /// Formats bytes to a human readable string.
  String formatBytes([int decimalPlaces = 2]) {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).roundTo(decimalPlaces)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).roundTo(decimalPlaces)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).roundTo(decimalPlaces)} GB';
  }
}