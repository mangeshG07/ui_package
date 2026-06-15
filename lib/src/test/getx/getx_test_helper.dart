import 'package:get/get.dart';

class GetXTestHelper {
  static void inject<T>(T controller) {
    Get.put<T>(controller);
  }

  static void reset() {
    Get.reset();
  }
}