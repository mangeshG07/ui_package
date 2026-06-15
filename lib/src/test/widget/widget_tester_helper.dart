import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetTesterHelper {
  static Future<void> enterText(
    WidgetTester tester,
    String key,
    String value,
  ) async {
    await tester.enterText(find.byKey(Key(key)), value);
  }

  static Future<void> tap(WidgetTester tester, String key) async {
    await tester.tap(find.byKey(Key(key)));
    await tester.pumpAndSettle();
  }
}
