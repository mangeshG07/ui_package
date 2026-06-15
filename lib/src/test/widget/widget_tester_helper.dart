import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetTesterHelper {
  static Future<void> enterText(
      WidgetTester tester,
      String key,
      String value,
      ) async {
    final finder = find.byKey(Key(key));

    // ✅ SAFETY CHECK (VERY IMPORTANT)
    expect(finder, findsOneWidget,
        reason: "❌ Widget with key '$key' not found");

    await tester.tap(finder);
    await tester.pump();

    await tester.enterText(finder, value);
    await tester.pumpAndSettle();
  }

  static Future<void> tap(WidgetTester tester, String key) async {
    final finder = find.byKey(Key(key));

    expect(finder, findsOneWidget,
        reason: "❌ Widget with key '$key' not found");

    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}