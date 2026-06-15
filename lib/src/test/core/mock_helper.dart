import 'package:mocktail/mocktail.dart';

class MockHelper {
  static void registerFallback<T>(T fake) {
    registerFallbackValue(fake);
  }
}