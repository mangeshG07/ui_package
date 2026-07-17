import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';

abstract class BaseController extends GetxController {
  Future<void> callApi<T>({
    required Future<Result<T>> Function() request,
    RxBool? loader,
    Function(T data)? onSuccess,
    Function(String message)? onError,
    bool showError = false,
  }) async {
    try {
      if (loader!.isTrue) return;
      loader.value = true;

      final result = await request();

      switch (result) {
        case Success():
          onSuccess?.call(result.data);
        case Failure():
          onError?.call(result.message);
          if (showError) _showError(result.message);
      }
    } finally {
      loader?.value = false;
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
