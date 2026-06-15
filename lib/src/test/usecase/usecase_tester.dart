import 'package:flutter_test/flutter_test.dart';

class UsecaseTester {
  static Future<void> testSuccess<T>({
    required Future<T> Function() call,
    required bool Function(T) validator,
  }) async {
    final result = await call();
    expect(validator(result), true);
  }

  static Future<void> testFailure<T>({
    required Future<T> Function() call,
    required bool Function(T) validator,
  }) async {
    final result = await call();
    expect(validator(result), false);
  }
}
