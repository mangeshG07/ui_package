import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Keyboard
  void hideKeyboard() => FocusScope.of(this).unfocus();
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  // Focus
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  /// Current screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Current screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Current screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Current view padding (inset for notches, home indicators, etc.).
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// True when the app is currently using the dark theme.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Shows a simple snackbar and returns a handle to hide it.
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          backgroundColor: backgroundColor,
        ),
      );
  }

  /// Pushes [page] onto the navigator.
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute<T>(builder: (_) => page));
  }

  /// Replaces the current route with [page].
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute<T>(builder: (_) => page));
  }

  /// Pops the current route, optionally returning [result].
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Dismisses the focused text field / keyboard.
  void unfocus() => FocusScope.of(this).unfocus();
}
