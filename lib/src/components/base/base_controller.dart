import 'package:get/get.dart';
import 'package:ui_package/src/network/result.dart';
import 'package:ui_package/ui_package.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;

  Future<void> callApi<T>({
    required Future<Result<T>> Function() request,
    Function(T data)? onSuccess,
    Function(String message)? onError,
  }) async {
    try {
      isLoading.value = true;

      final result = await request();

      switch (result) {
        case Success():
          onSuccess?.call(result.data);
        case Failure():
          onError?.call(result.message);
          _showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    CustomSnackbar.show(
      message: message,
      context: Get.context!,
      type: SnackbarType.error,
    );
  }
}
